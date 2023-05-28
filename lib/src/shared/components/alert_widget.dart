import 'package:casino_test/src/shared/styles/appColors.dart';
import 'package:flutter/material.dart';

class AlertWidget extends StatelessWidget {
  final String menssage;
  AlertWidget({required this.menssage, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.08,
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              menssage,
              style: TextStyle(
                  color: AppColors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
