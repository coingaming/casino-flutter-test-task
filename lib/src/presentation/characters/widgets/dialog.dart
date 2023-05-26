import 'package:flutter/material.dart';

showAnimatedDialog(BuildContext context, Widget child,
    {bool dismiss = true, Alignment alignMent = Alignment.center}) {
  return showGeneralDialog(
    barrierLabel: '',
    barrierDismissible: dismiss,
    barrierColor: Theme.of(context).secondaryHeaderColor.withOpacity(0.0),
    transitionDuration: const Duration(milliseconds: 500),
    context: context,
    pageBuilder: (_, animationOne, animationTwo) {
      return Align(
        alignment: alignMent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              child,
            ],
          ),
        ),
      );
    },
    transitionBuilder: (_, animationOne, animationTwo, animatedChild) {
      return SlideTransition(
        position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(animationOne),
        child: animatedChild,
      );
    },
  );
}
