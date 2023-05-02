import 'package:casino_test/src/data/models/character.dart';
import 'package:casino_test/src/presentation/widgets/character_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CharacterDetails extends StatelessWidget {
  const CharacterDetails({Key? key, required this.character}) : super(key: key);

  final Character character;

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> charDataList = character.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 1.sw,
              child: CharacterImage(
                character: character,
              ),
            ),
            SizedBox(
              child: Card(
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: charDataList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map<String, String> charData = charDataList[index];
                      String value = charData.values.first == ''
                          ? 'None'
                          : charData.values.first;
                      return ListTile(
                        title: Text(value),
                        subtitle: Text(charData.keys.first),
                      );
                    },
                  ),
                  elevation: 5.sp,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.sp))),
            ),
          ],
        ),
      ),
    );
  }
}
