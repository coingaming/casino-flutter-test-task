import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/presentation/screens/character_details.dart';
import 'package:casino_test/src/presentation/widgets/character_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleCharacter extends StatelessWidget {
  SingleCharacter({Key? key, required this.character}) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        semanticContainer: false,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               Flexible(
      child: FractionallySizedBox(
        heightFactor: 0.9,
        widthFactor: 1,
        child:  CharacterImage(character: character),
      ),
    ),
              Padding(
                padding: EdgeInsets.only(top: 8.sp),
                child: Text(
                  character.name ,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CharacterDetails(character: character),
          ),
        );
      },
    );
  }
}


