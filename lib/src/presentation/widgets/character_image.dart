import 'package:casino_test/src/data/models/character.dart';
import 'package:flutter/material.dart';

class CharacterImage extends StatelessWidget {
  const CharacterImage({Key? key, required this.character}) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      character.image,
      fit: BoxFit.fill,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder: (context, exception, stackTrace) {
        return Text('Error Occurred, Please reload');
      },
    );
  }
}
