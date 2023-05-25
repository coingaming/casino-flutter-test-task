import 'package:casino_test/src/presentation/characters/widgets/image_widget.dart';
import 'package:flutter/material.dart';

class CharacterWidget extends StatelessWidget {
  const CharacterWidget({super.key, required this.image, required this.name});
  final String image;
  final String name;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 10) +
          const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              spreadRadius: 0,
              offset: Offset(0, 2),
              color: Colors.black.withOpacity(0.06),
            )
          ],
          borderRadius: BorderRadius.circular(8)),
      child: Row(children: [
        NetworkImageWidget(image: image),
        const SizedBox(
          width: 20,
          height: 50,
        ),
        Text(
          name,
          style: Theme.of(context).primaryTextTheme.headlineSmall?.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.8)),
        )
      ]),
    );
  }
}
