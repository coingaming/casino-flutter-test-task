import 'package:casino_test/src/data/models/character/character_model.dart';
import 'package:casino_test/src/presentation/ui/components/character_details.dart';
import 'package:casino_test/src/presentation/ui/contants/map_widgets.dart';
import 'package:flutter/material.dart';
import 'package:casino_test/src/shared/extensions/wrap_widget.dart';

class CharacterWidget extends StatelessWidget {
  final CharacterModel character;
  CharacterWidget({required this.character, Key? key}) : super(key: key);
  final Map<String, Widget> _statusWidget = MapWidgets.mapStatusWidgets;
  @override
  Widget build(BuildContext context) {
    return _characterWidget(context, character);
  }

  Widget _characterWidget(BuildContext context, CharacterModel character) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: SizedBox(
                      width: 60,
                      child: Row(
                        children: [
                          Tooltip(
                            message: character.location.name,
                            child: character.location.name == "unknown"
                                ? Icon(Icons.help)
                                : Icon(Icons.location_on),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      character.name,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Tooltip(
                    message: character.status,
                    child: _statusWidget[character.status.toLowerCase()]!,
                  ),
                ]),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CharacterDetailsWidget(character: character);
                },
              );
            },
            child: Image.network(
              character.image,
              width: 100,
              height: 100,
            ),
          ),
        ],
      ).wrapCardBorder(
        padding: EdgeInsets.all(8),
        width: double.infinity,
      ),
    );
  }
}
