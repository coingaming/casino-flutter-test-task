import 'package:casino_test/src/data/models/character.dart';
import 'package:flutter/material.dart';

class CharacterDetailWidget extends StatelessWidget {
  final Character character;
  const CharacterDetailWidget({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).primaryTextTheme.headlineSmall?.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.black.withOpacity(0.8));
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
          color: Color(0xFFF5F2F0),
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, 1),
                color: Theme.of(context).secondaryHeaderColor.withOpacity(0.06))
          ],
          borderRadius: BorderRadius.circular(15)),
      child: Column(children: [
        Row(
          children: [
            Text(
              "Name:",
              style: style,
            ),
            const SizedBox(
              width: 20,
            ),
            Text("${character.name}", style: style),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              "Gender:",
              style: style,
            ),
            const SizedBox(
              width: 20,
            ),
            Text("${character.gender}", style: style),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              "Species:",
              style: style,
            ),
            const SizedBox(
              width: 20,
            ),
            Text("${character.species}", style: style),
          ],
        )
      ]),
    );
  }
}
