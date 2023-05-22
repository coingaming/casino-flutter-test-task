import 'package:casino_test/src/data/models/character.dart';
import 'package:flutter/material.dart';

class CharacterTileWidget extends StatelessWidget {
  final Character _character;
  final Function() _onTap;

  const CharacterTileWidget({super.key, required Character character, required Function() onTap})
      : _character = character,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: 300,
          height: 300,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image.network(
                _character.image,
                loadingBuilder: (_, child, loadingProgress) {
                  return loadingProgress == null
                      ? child
                      : const Center(child: CircularProgressIndicator());
                },
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                color: Theme.of(context).colorScheme.primary,
                child: Text(
                  _character.name,
                  style: Theme.of(context).textTheme.titleMedium?.apply(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
