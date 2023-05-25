import 'dart:developer';

import 'package:casino_test/src/data/models/character/character_model.dart';
import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/bloc/main_event.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:casino_test/src/presentation/ui/shared/components/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

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
        _scrollController.position.maxScrollExtent;

    if (canFetch) {
      _mainPageBloc.add(const GetNextPageOnMainPageEvent(true));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onSubmitedCallBack: (name) =>
            _mainPageBloc.add(SearchCharacterOnMainPageEvent(name)),
        onClear: () => _mainPageBloc.add(const GetTestDataOnMainPageEvent(1)),
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
                final snackBar = SnackBar(
                    duration: const Duration(seconds: 5),
                    dismissDirection: DismissDirection.startToEnd,
                    padding: EdgeInsets.zero,
                    content: AlertWidget(menssage: "Loading more data"));

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              }
              if (state.alert == MainPageAlert.empty) {
                final snackBar = SnackBar(
                    duration: const Duration(seconds: 2),
                    dismissDirection: DismissDirection.startToEnd,
                    padding: EdgeInsets.zero,
                    content: AlertWidget(menssage: "No data found"));

                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            }
          },
          builder: (blocContext, state) {
            if (state is LoadingMainPageState) {
              return _loadingWidget(context);
            } else if (state is SuccessfulMainPageState) {
              return _successfulWidget(context, state);
            } else if (state is ErrorMainPageState) {
              return Center(child: Text("${state.message}"));
            }
            return Container();
          },
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
        child: const CircularProgressIndicator(),
      ),
    );
  }

  Widget _successfulWidget(
      BuildContext context, SuccessfulMainPageState state) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          ListView.builder(
            controller: _scrollController,
            itemCount: state.characters.length,
            itemBuilder: (context, index) {
              return _characterWidget(context, state.characters[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _characterWidget(BuildContext context, CharacterModel character) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: double.infinity,
        decoration: ShapeDecoration(
          color: Color.fromARGB(120, 204, 255, 255),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text(character.name),
            ),
            Image.network(
              character.image,
              width: 50,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class AlertWidget extends StatelessWidget {
  final String menssage;
  AlertWidget({required this.menssage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              menssage,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
