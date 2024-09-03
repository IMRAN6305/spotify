import 'package:flutter/material.dart';
import 'package:spotify/core/configs/theme/app_colors.dart';

class AppTheme {

  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor:  AppColors.lightBackground,
    brightness: Brightness.light,
    fontFamily: "Satoshi",
      inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.transparent,
          filled: true,
          hintStyle: const TextStyle(
              color: Color(0xff383838),
              fontWeight: FontWeight.w500
          ),
          contentPadding: const EdgeInsets.all(30),
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.black,
                  width: 0.4
              ),
              borderRadius: BorderRadius.circular(30)
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.black,
                  width: 0.4
              ),
              borderRadius: BorderRadius.circular(30)
          )
      ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        elevation: 0,
        textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0)
        )
      )
    )

  );
  static final darkTheme = ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor:  AppColors.darkBackground,
      brightness: Brightness.dark,
      fontFamily: "Satoshi",
      inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.transparent,
          filled: true,
          hintStyle: const TextStyle(
            color: Color(0xffa7a7a7),
            fontWeight: FontWeight.w500
          ),
          contentPadding: const EdgeInsets.all(30),
          border: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.white,
                  width: 0.4
              ),
              borderRadius: BorderRadius.circular(30)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.white,
              width: 0.4
            ),
              borderRadius: BorderRadius.circular(30)
          )
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              elevation: 0,
              textStyle: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
              )
          )
      )

  );
}