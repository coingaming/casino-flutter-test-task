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
  final bool? hasConnection;
  CharactersScreen({this.hasConnection, Key? key}) : super(key: key);
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
    _mainPageBloc = context.read<MainPageBloc>();

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
          hasConnection: widget.hasConnection ?? false,
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
        body: BlocConsumer<MainPageBloc, MainPageState>(
          bloc: _mainPageBloc,
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
              if (state.hasConnection != null) {
                if (!state.hasConnection!) {
                  _showLocalSnackBar(context, "No internet connection", 3);
                }
              }
            }
          },
          builder: (blocContext, state) {
            if (state is LoadingMainPageState) {
              return _loading();
            } else if (state is SuccessfulMainPageState) {
              return _successfulWidget(context, state);
            } else if (state is ErrorMainPageState) {
              return _refreshBody(state.message);
            }
            if (state is LostConnectionState && !widget.hasConnection!) {
              return _refreshBody("No internet connection");
            }
            return Center(
              child: _refreshButton(),
            );
          },
        ),
      ),
    );
  }

  Widget _loading() {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 150,
        child: Column(
          children: [
            _loadingWidget(context),
            TextButton(
                onPressed: () {
                  _mainPageBloc.add(const GetTestDataOnMainPageEvent(1));
                },
                child: Text(
                  "Refresh",
                  style: TextStyle(color: Colors.black),
                )),
          ],
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
    if (state.characters.isEmpty) {
      return Column(
        children: [
          Text("No data found"),
          _refreshButton(),
        ],
      );
    }
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

  Widget _refreshBody(String message) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(message),
                _refreshButton(),
              ],
            )));
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
