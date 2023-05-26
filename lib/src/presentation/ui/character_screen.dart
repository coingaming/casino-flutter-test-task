import 'package:casino_test/src/data/models/character/character_model.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/bloc/main_event.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:casino_test/src/presentation/ui/components/character_widget.dart';
import 'package:casino_test/src/shared/components/alert_widget.dart';
import 'package:casino_test/src/shared/components/custom_appbar_widget.dart';
import 'package:casino_test/src/shared/styles/appColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:casino_test/src/shared/extensions/wrap_widget.dart';

@immutable
class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late final ScrollController _scrollController;
  late final MainPageBloc _mainPageBloc;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _mainPageBloc = MainPageBloc(
        InitialMainPageState(), GetIt.I.get<CharactersRepository>());

    _scrollController.addListener(_infinityScrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _infinityScrollListener() {
    bool canFetch = _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_mainPageBloc.state.isFetching;

    if (canFetch) {
      _mainPageBloc.add(const GetNextPageOnMainPageEvent(true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.secondary,
        appBar: CustomAppBarWidget(
          onSubmitedCallBack: (name) {
            if (name.isNotEmpty) {
              _mainPageBloc.add(SearchCharacterOnMainPageEvent(name));
            }
          },
          onClearCallback: (name) {
            if (_mainPageBloc.state is SuccessfulMainPageState) {
              if ((_mainPageBloc.state as SuccessfulMainPageState)
                  .characters
                  .isEmpty) {
                _mainPageBloc.add(const GetTestDataOnMainPageEvent(1));
              }
            }
            FocusScope.of(context).unfocus();
          },
          searchController: searchController,
          title: "Search character",
        ),
        body: BlocProvider<MainPageBloc>(
          create: (context) {
            _mainPageBloc..add(const GetTestDataOnMainPageEvent(1));
            return _mainPageBloc;
          },
          child: BlocConsumer<MainPageBloc, MainPageState>(
            listener: (context, state) {
              if (state is SuccessfulMainPageState) {
                if (state.isFetching) {
                  _showLocalSnackBar(context, "Loading more data", 5);
                } else {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                }
                if (state.alert == MainPageAlert.empty) {
                  _showLocalSnackBar(context, "No data found", 3);
                }
              }
            },
            builder: (blocContext, state) {
              if (state is LoadingMainPageState) {
                return _loadingWidget(context);
              } else if (state is SuccessfulMainPageState) {
                return _successfulWidget(context, state);
              } else if (state is ErrorMainPageState) {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${state.message}"),
                      _refreshButton(),
                    ],
                  ).wrapCardBorder(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.15),
                ));
              }
              return Center(
                child: _refreshButton(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _loadingWidget(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: const CircularProgressIndicator(
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget _successfulWidget(
      BuildContext context, SuccessfulMainPageState state) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: RefreshIndicator(
        onRefresh: () => Future.sync(() {
          _mainPageBloc.add(const GetTestDataOnMainPageEvent(1));
        }),
        child: Stack(
          children: [
            ListView.builder(
              controller: _scrollController,
              itemCount: state.characters.length,
              padding: EdgeInsets.only(top: 16, bottom: 16),
              itemBuilder: (context, index) {
                return CharacterWidget(
                  character: state.characters[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _refreshButton() {
    return IconButton(
      icon: Icon(Icons.refresh),
      onPressed: () => _mainPageBloc.add(const GetTestDataOnMainPageEvent(1)),
    );
  }

  void _showLocalSnackBar(BuildContext context, String message, int duration) {
    final snackBar = SnackBar(
        duration: Duration(seconds: duration),
        dismissDirection: DismissDirection.startToEnd,
        padding: EdgeInsets.zero,
        content: AlertWidget(menssage: message));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
