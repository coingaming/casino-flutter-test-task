import 'package:casino_test/src/shared/styles/appColors.dart';
import "package:flutter/material.dart";

extension CustomCard on Widget {
  Widget wrapContainer(
      {double? width,
      double? height,
      Color? color = AppColors.white,
      EdgeInsets padding = const EdgeInsets.all(0),
      double? radius = 4}) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius!),
      ),
      width: width,
      height: height,
      padding: padding,
      child: this,
    );
  }

  Widget wrapCardBorder(
      {double? width,
      double? height,
      Color? color = AppColors.white,
      Color? borderColor = Colors.green,
      EdgeInsets padding = const EdgeInsets.all(0),
      double? radius = 4}) {
    return Container(
        padding: padding,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 3,
            color: AppColors.border,
          ),
        ),
        width: width,
        height: height,
        child: this);
  }
}
