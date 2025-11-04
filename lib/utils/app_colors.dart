import 'package:flutter/material.dart';

bool isDarkMode(BuildContext context) {
  final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
  return isDark;
}

class AppColors {
  Color primaryColor(BuildContext context) =>
      isDarkMode(context) ? Colors.white : Color(0XFF131313);

  Color cardColor(BuildContext context) =>
      isDarkMode(context) ? Color(0XFF1C1C1C) : Color(0XFF131313);

  Color backgroundColor(BuildContext context) =>
      isDarkMode(context) ? Color(0XFF131313) : Color(0XFFF6F6F6);

  Color titleColors(BuildContext context) =>
      isDarkMode(context) ? Colors.white : Color(0XFF131313);

  Color cardLightColor(BuildContext context) =>
      isDarkMode(context) ? Colors.white : Colors.white;

  Color subTitleColor(BuildContext context) =>
      isDarkMode(context) ? Color(0XFFF1F1F1) : Color(0XFF959595);

  Color shadowColors(BuildContext context) =>
      isDarkMode(context) ? Colors.transparent : Color(0XFFE3E3E3);

  Color dividerColor(BuildContext context) =>
      isDarkMode(context) ? Color(0XFFE3E3E3) : Color(0XFFE3E3E3);

  Color transaprent = Colors.transparent;

  Color white(BuildContext context) =>
      isDarkMode(context) ? Color(0XFF303030) : Colors.white;
}
