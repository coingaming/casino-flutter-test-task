import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/presentation/characters/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/characters/bloc/main_event.dart';
import 'package:casino_test/src/presentation/characters/bloc/main_state.dart';
import 'package:casino_test/src/presentation/characters/widgets/character_detail_widget.dart';
import 'package:casino_test/src/presentation/characters/widgets/character_widget.dart';
import 'package:casino_test/src/presentation/characters/widgets/dialog.dart';
import 'package:casino_test/src/presentation/characters/widgets/search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@immutable
class CharactersScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final _search = TextEditingController();
  final List<Character> characterDatas = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF5F2F0),
        body: BlocProvider(
          create: (blocContext) => MainPageBloc(
            InitialMainPageState(),
            GetIt.I.get<CharactersRepository>(),
          )..add(const GetTestDataOnMainPageEvent()),
          child: BlocConsumer<MainPageBloc, MainPageState>(
            listener: (context, state) {
              if (state is SuccessfulMainPageState && state.error.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  state.error,
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headlineSmall
                      ?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.red.withOpacity(0.8)),
                )));
              }
            },
            builder: (blocContext, state) {
              return switch (state) {
                InitialMainPageState() => _loadingWidget(context),
                LoadingMainPageState() => _loadingWidget(context),
                SuccessfulMainPageState() => _successfulWidget(
                    blocContext,
                    state,
                    characterDatas,
                  ),
                ErrorMainPageState(error: String error) =>
                  _errorWidget(context, error, retry: true, ontap: () {
                    blocContext
                        .read<MainPageBloc>()
                        .add(const GetTestDataOnMainPageEvent());
                  }),
                UnSuccessfulMainPageState(reason: String reason) =>
                  _errorWidget(context, reason),
              };
            },
          ),
        ),
      ),
    );
  }

  Widget _loadingWidget(BuildContext context,
      {double height = 50, double width = 50}) {
    return Center(
      child: Container(
        width: height,
        height: width,
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: const CircularProgressIndicator(
          color: Colors.brown,
        ),
      ),
    );
  }

  Widget _errorWidget(BuildContext context, String error,
      {bool retry = false, Function()? ontap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            '$error',
            textAlign: TextAlign.center,
            style: Theme.of(context).primaryTextTheme.headlineSmall?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black.withOpacity(0.8)),
          ),
        ),
        if (retry)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: GestureDetector(
              onTap: ontap,
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(15)),
                alignment: Alignment.center,
                child: Text(
                  'Retry',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headlineSmall
                      ?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                ),
              ),
            ),
          )
      ],
    );
  }

  Widget _successfulWidget(BuildContext context, SuccessfulMainPageState state,
      List<Character> data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 15,
        ),
        SearchWidget(controller: _search),
        const SizedBox(
          height: 25,
        ),
        ValueListenableBuilder(
            valueListenable: _search,
            builder: (_, value, child) {
              final characters = switch (value.text) {
                "" => state.characters,
                (String s) => state.characters
                    .where((c) => c.toString().contains(s.toLowerCase()))
                    .toList(),
              };

              return characters.isEmpty
                  ? _errorWidget(context, "No result for search")
                  : Expanded(
                      child: ListView.builder(
                        cacheExtent: double.infinity,
                        controller: _scrollController
                          ..addListener(() {
                            if (_scrollController.offset ==
                                    _scrollController
                                        .position.maxScrollExtent &&
                                !state.loadingMoreData) {
                              if (!state.loadingMoreData) {
                                context.read<MainPageBloc>().add(
                                    AddMoreDataOnMainPageEvent(
                                        state.nextPageUrl));
                              }
                            }
                          }),
                        itemCount: state.loadingMoreData
                            ? (characters.length + 1)
                            : characters.length,
                        itemBuilder: (context, index) {
                          bool showLoading = state.loadingMoreData &&
                              index == characters.length;

                          return showLoading
                              ? _loadingWidget(context, height: 20, width: 20)
                              : GestureDetector(
                                  onTap: () {
                                    showAnimatedDialog(
                                        context,
                                        CharacterDetailWidget(
                                          character: characters[index],
                                        ));
                                  },
                                  child: CharacterWidget(
                                    image: characters[index].image,
                                    name: characters[index].name,
                                  ),
                                );
                        },
                      ),
                    );
            })
      ],
    );
  }
}
