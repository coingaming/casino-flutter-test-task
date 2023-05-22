import 'dart:math';

import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/presentation/bloc/main_bloc.dart';
import 'package:casino_test/src/presentation/bloc/main_event.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:casino_test/src/presentation/ui/characters_screen/components/character_details_widget.dart';
import 'package:casino_test/src/presentation/ui/characters_screen/components/character_tile_widget.dart';
import 'package:casino_test/src/presentation/ui/shared/custom_error_widget.dart';
import 'package:casino_test/src/presentation/ui/shared/custom_loading_indicator.dart';
import 'package:casino_test/src/presentation/ui/shared/custom_search_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

@immutable
class CharactersListScreen extends StatefulWidget {
  const CharactersListScreen({super.key});

  @override
  State<CharactersListScreen> createState() => _CharactersListScreenState();
}

class _CharactersListScreenState extends State<CharactersListScreen> {
  late final ScrollController _scrollController;
  late final MainPageBloc bloc;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bloc = MainPageBloc();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<MainPageBloc>(
        create: (context) => bloc..add(const GetTestDataOnMainPageEvent()),
        child: BlocConsumer<MainPageBloc, MainPageState>(
          listener: (context, state) {},
          builder: (context, state) {
            return switch (state) {
              InitialMainPageState() => const CustomLoadingIndicator(),
              LoadingMainPageState() => const CustomLoadingIndicator(),
              SuccessfulMainPageState() => _successfulWidget(context, state),
              UnSuccessfulMainPageState() => _errorWidget(state.error)
            };
          },
        ),
      ),
    );
  }

  Widget _errorWidget(String error) {
    return CustomErrorWidget(
      errorTitle: error,
      errorActionButtons: DualErrorActionButtons(
        buttons: [
          SingleErrorActionButton(
            action: () {
              if (_searchController.text.isEmpty) {
                bloc.add(
                  GetFilteredDataOnMainPageEvent(
                    forceRefresh: true,
                    filter: _searchController.text,
                    isLoadingNextPage: false,
                  ),
                );
              } else if (_searchController.text.isEmpty) {
                bloc.add(
                  const GetTestDataOnMainPageEvent(forceRefresh: true),
                );
              }
            },
            text: 'Retry',
          ),
          SingleErrorActionButton(
            action: () {
              _searchController.clear();
              bloc.add(
                const GetTestDataOnMainPageEvent(forceRefresh: true),
              );
            },
            text: 'Continue',
          ),
        ],
      ),
    );
  }

  Widget _successfulWidget(BuildContext context, SuccessfulMainPageState state) {
    return Scaffold(
      appBar: CustomSearchAppBar(
        title: 'Rick and Morty Characters',
        searchController: _searchController,
        trailing: _searchBarTrailingButton,
        onSearchChanged: (value) => _onSearchChanged(value, state),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _searchController.clear();
          bloc.add(const GetTestDataOnMainPageEvent(forceRefresh: true, filter: null));
        },
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 24.0,
          ),
          controller: _scrollController,
          itemCount: state.characters.length,
          itemBuilder: (context, index) {
            bool shouldAnimate = state.hasNextPage && state.characters.length <= 20;
            int delay = min(100 + 100 * index, 400);

            _handleInfiniteScroll(
              hasNextPage: state.hasNextPage,
              currentIndex: index,
              length: state.characters.length,
              isLoadingNextPage: state.isLoadingNextPage,
            );

            return shouldAnimate
                ? Animate(
                    effects: [FadeEffect(delay: delay.ms)],
                    child: _characterWidget(context, state.characters[index]),
                  )
                : _characterWidget(context, state.characters[index]);
          },
        ),
      ),
    );
  }

  Widget _characterWidget(BuildContext context, Character character) {
    return CharacterTileWidget(
      character: character,
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: ([...Colors.primaries]..shuffle())[0],
          isScrollControlled: true,
          builder: (context) {
            return CharacterDetailsWidget(character: character);
          },
        );
      },
    );
  }

  Widget get _searchBarTrailingButton {
    return IconButton(
      icon: const Icon(MdiIcons.close),
      onPressed: () {
        if (_searchController.text.isEmpty) {
          return;
        }
        _searchController.clear();
        bloc.add(
          GetTestDataOnMainPageEvent(filter: _searchController.text),
        );
      },
    );
  }

  void _onSearchChanged(String value, SuccessfulMainPageState state) {
    if (value.isNotEmpty && value.length > 2) {
      bloc.add(
        GetFilteredDataOnMainPageEvent(
          forceRefresh: true,
          filter: _searchController.text,
          isLoadingNextPage: state.isLoadingNextPage,
        ),
      );
    } else if (_searchController.text.isEmpty) {
      bloc.add(
        const GetTestDataOnMainPageEvent(forceRefresh: true),
      );
    }
  }

  void _handleInfiniteScroll({
    required currentIndex,
    required int length,
    required bool isLoadingNextPage,
    required bool hasNextPage,
  }) {
    if (hasNextPage && currentIndex == length - 1 && !isLoadingNextPage) {
      bloc.add(const GetNextPageOnMainPageEvent());
    }
    return;
  }
}
