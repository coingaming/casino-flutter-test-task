import 'dart:io';

import 'package:casino_test/src/bloc/main_bloc.dart';
import 'package:casino_test/src/bloc/main_event.dart';
import 'package:casino_test/src/bloc/main_state.dart';
import 'package:casino_test/src/presentation/widgets/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogHelper {
  static showAppDialog(BuildContext context, MainPageState state) {
    if (Platform.isIOS) {
      showCupertinoDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => AppDialog(
                title: state.errorMessage?.prefix,
                description: state.errorMessage?.message,
                onPressed: () {
                  Navigator.pop(context);
                  context
                      .read<MainPageBloc>()
                      .add(GetTestDataOnMainPageEvent());
                },
              ));
    }

    if (Platform.isAndroid) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => AppDialog(
              title: state.errorMessage?.prefix,
              description: state.errorMessage?.message,
              onPressed: () {
                Navigator.pop(context);
                context.read<MainPageBloc>().add(GetTestDataOnMainPageEvent());
              }));
    }
  }
}
