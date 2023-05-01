import 'package:flutter/material.dart';
import 'package:casino_test/src/bloc/main_state.dart';
import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/presentation/widgets/single_character.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CharacterList extends StatelessWidget {
  const CharacterList({
    Key? key,
    required this.scrollController,
    required this.state,
  }) : super(key: key);

  final ScrollController scrollController;
  final MainPageState state;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5.sp,
          mainAxisSpacing: 8.sp,
          mainAxisExtent: 0.36.sh),
      itemCount: state.characters.length,
      itemBuilder: (context, int index) {
        Character character = state.characters[index];
        return SingleCharacter(
          character: character,
        );
      },
    );
  }
}
