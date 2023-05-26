import 'package:casino_test/src/data/models/character/character_model.dart';
import 'package:casino_test/src/presentation/ui/contants/map_widgets.dart';
import 'package:casino_test/src/shared/styles/appColors.dart';
import 'package:casino_test/src/shared/extensions/wrap_widget.dart';

import 'package:flutter/material.dart';

class CharacterDetailsWidget extends StatelessWidget {
  final CharacterModel character;
  CharacterDetailsWidget({required this.character, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _customModal(character);
  }

  final Map<String, Widget> _statusWidget = MapWidgets.mapStatusWidgets;

  Widget _customModal(CharacterModel character) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Dialog(
        insetPadding: EdgeInsets.zero,
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          character.name,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        Tooltip(
                          message: character.status,
                          child: _statusWidget[character.status.toLowerCase()]!,
                        ),
                      ],
                    ),
                    Text(
                      "Specie: ${character.species}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "Origin: ${character.origin.name}",
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "Gender: ${character.gender}",
                      overflow: TextOverflow.visible,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "Last known location: ${character.location.name}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
            Image.network(
              character.image,
              width: 100,
              height: 100,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  child: Center(
                    child: Text("Image not found"),
                  ),
                );
              },
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.all(16),
                alignment: Alignment.center,
                width: double.infinity,
                color: AppColors.primary,
                child: Text(
                  "Close",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ],
        ).wrapContainer(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width),
      );
    });
  }
}
