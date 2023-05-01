import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog(
      {Key? key, this.title, this.description, required this.onPressed})
      : super(key: key);

  final String? title;
  final String? description;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
          title: Text(title ?? ''),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description ?? ''),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          actions: <Widget>[
              TextButton(
                child: const Text('Retry'),
                onPressed: onPressed,
              ),
          ]);
    } else {
      return AlertDialog(
          title: Text(title ?? ''),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(description ?? ''),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          actions: <Widget>[
              TextButton(
                child: const Text('Retry'),
                onPressed: onPressed,
              ),
          ]);
    }
  }
}
