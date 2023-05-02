import 'package:casino_test/src/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;

    notifyListeners();
  }

  static ThemeData get lightTheme {
    final ThemeData theme = ThemeData();
    return ThemeData(
        primaryColor: CustomColors.kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: CustomColors.kPrimaryColor,
          titleTextStyle:
              TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          actionsIconTheme: const IconThemeData(color: Colors.white),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
              color: CustomColors.textColor,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold),
          displayMedium: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold),
          displaySmall: TextStyle(
              color: CustomColors.textColor,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: CustomColors.textColor, fontSize: 14.sp),
          titleMedium: TextStyle(
              color: CustomColors.textColor,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500),
          titleSmall: TextStyle(color: CustomColors.textColor, fontSize: 20.sp),
          bodyLarge: TextStyle(
              color: CustomColors.textColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(color: CustomColors.textColor, fontSize: 16.sp),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp)),
            backgroundColor:
                MaterialStateProperty.all(CustomColors.kLightGreen),
            padding:
                MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 8.sp)),
          ),
        ),
        colorScheme: theme.colorScheme
            .copyWith(secondary: CustomColors.kAccentColor)
            .copyWith(background: Colors.white));
  }

  static ThemeData get darkTheme {
    final ThemeData theme = ThemeData();
    return ThemeData(
        primaryColor: CustomColors.kPrimaryColor,
        scaffoldBackgroundColor: CustomColors.grey,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: CustomColors.kPrimaryColor,
          titleTextStyle:
              TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          actionsIconTheme: const IconThemeData(color: Colors.white),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold),
          displayMedium: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
          displaySmall: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: CustomColors.textColor, fontSize: 14.sp),
          titleMedium: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold),
          titleSmall: TextStyle(color: Colors.white, fontSize: 20.sp),
          bodyLarge: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(color: Colors.white, fontSize: 16.sp),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp)),
            backgroundColor:
                MaterialStateProperty.all(CustomColors.kLightGreen),
            padding:
                MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 8.sp)),
          ),
        ),
        colorScheme: theme.colorScheme
            .copyWith(secondary: CustomColors.kAccentColor)
            .copyWith(background: CustomColors.grey));
  }
}
