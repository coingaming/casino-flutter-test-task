import 'package:casino_test/src/bloc/main_bloc.dart';
import 'package:casino_test/src/bloc/main_event.dart';
import 'package:casino_test/src/bloc/main_state.dart';
import 'package:casino_test/src/presentation/widgets/bottom_error_card.dart';
import 'package:casino_test/src/presentation/widgets/character_list.dart';
import 'package:casino_test/src/utils/dialog_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/bottom_loader.dart';

@immutable
class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Characters'),
      ),
      body: BlocConsumer<MainPageBloc, MainPageState>(
        listener: (context, state) {
          if (state.status.isError && state.characters.isEmpty) {
            DialogHelper.showAppDialog(context, state);
          }
        },
        builder: (blocContext, state) {
          if (state.status.isLoading && state.characters.isEmpty) {
            return _loadingWidget(context);
          } else {
            return _successfulWidget(context, state);
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom)
      context.read<MainPageBloc>().add(GetTestDataOnMainPageEvent());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
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

  Widget _successfulWidget(BuildContext context, MainPageState state) {
    return SafeArea(
        child: Column(
      children: [
        Flexible(
          child: CharacterList(
            state: state,
            scrollController: _scrollController,
          ),
        ),
        if (state.status.isLoading) BottomLoader(),
        if (state.status.isError && !state.hasReachedMax)
          BottomErrorCard(
            title: state.errorMessage?.prefix ?? '',
            description: state.errorMessage?.message ?? '',
            onPressed: () => context
                .read<MainPageBloc>()
                .add(RetryDataFetchOnMainPageEvent(context)),
          )
      ],
    ));
  }
}
