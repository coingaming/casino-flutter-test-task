import 'package:casino_test/src/data/models/character.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CharacterDetailsWidget extends StatelessWidget {
  final Character _character;

  const CharacterDetailsWidget({super.key, required Character character}) : _character = character;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 32.0),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(MdiIcons.closeCircle, color: Colors.grey[900]),
                onPressed: () => Navigator.of(context).pop(),
              )),
          Container(
            margin: const EdgeInsets.all(16),
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[800]!, width: 4),
              borderRadius: BorderRadius.circular(16),
              image: DecorationImage(
                image: NetworkImage(_character.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(
              TextSpan(
                text: _character.name,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      decoration: _getCharStatus(_character.status).isDead
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationColor: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                children: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Tooltip(
                        textStyle:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        message: _character.status,
                        preferBelow: false,
                        child: _getCharStatus(_character.status).icon,
                      ),
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white.withOpacity(0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Gender: ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: _character.gender,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "Species: ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: _character.species,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "Location: ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: _character.location.name,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "Appearances: ",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                          text: _character.episode.length.toString(),
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  ({Widget icon, bool isDead}) _getCharStatus(String status) {
    return (
      icon: switch (status.toLowerCase()) {
        'alive' => const Icon(MdiIcons.heartPulse, color: Colors.red),
        'dead' => Icon(MdiIcons.graveStone, color: Colors.grey[800]),
        _ => Icon(MdiIcons.helpCircle, color: Colors.grey[800]),
      },
      isDead: status.toLowerCase() == 'dead'
    );
  }
}
