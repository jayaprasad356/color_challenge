import 'package:flutter/material.dart';

extension colors on ColorScheme {
  static MaterialColor primary_app = const MaterialColor(
    0xffFC6A57,
    <int, Color>{
      50: primary,
      100: primary,
      200: primary,
      300: primary,
      400: primary,
      500: primary,
      600: primary,
      700: primary,
      800: primary,
      900: primary,
    },
  );

  static const Color yellow = Color(0xfffdd901);

  static const Color red = Colors.red;

  static const Color darkColor = Color(0xff181616);
  static const Color darkColor2 = Color(0xff252525);
  static const Color darkColor3 = Color(0xffa0a1a0);

  static const Color white10 = Colors.white10;
  static const Color white30 = Colors.white30;
  static const Color white70 = Colors.white70;

  static const Color black54 = Colors.black54;
  static const Color black12 = Colors.black12;
  static const Color disableColor = Color(0xffEEF2F9);
  static const Color greyss = Color(0xFFB9B9B9);
  static const Color light_greyss = Color(0x6EB9B9B9);
  static const Color profile_grey = Color(0xFFE0DCDC);
  static const Color primary = Color(0xFF2743FD);
  static const Color cc_telegram = Color(0xFF229ED9);
  static const Color cc_telegram_light = Color(0xFF75C8EF);
  static const Color cc_whatsapp = Color(0xFF128C7E);
  static const Color bg_white = Color(0xFFF5F5F5);
  static const Color cc_green = Color(0xFF32A852);
  static const Color primary_color = Color(0xFF171D82);
  static const Color secondary_color = Color(0xFF060839);
  static const Color primary_color2 = Color(0xFF060839);
  static const Color widget_color = Color(0xFFF59A09);
  static const Color widget_color2 = Color(0xFF6D1A52);
  static const Color dkgreen = Color(0xFF004113);
  static const Color cc_skyblue = Color(0xFF22A7F0);
  static const Color cc_red = Color(0xFFCF000F);
  static const Color cc_pink = Color(0xFFC93756);
  static const Color cc_velvet = Color(0xFF750851);
  static const Color gold_dark = Color(0xFFDAA520);
  static const Color gold_light = Color(0xFFFFD700);
  static const Color cc_yellow = Color(0xFFFFB61E);
  static const Color cc_purpul = Color(0xFF8E44AD);
  static const Color cc_list_grey = Color(0xFFF5F6FA);
  static const Color cc_lite_purple = Color(0xFF6E76F3);
  static const Color cc_border_gray = Color(0xFFADADAD);
  static const Color cc_button_grey = Color(0xFFF1F3FF);
  static const Color cc_greyText = Color(0xFF877E7E);
  static const Color cc_card_bg = Color(0xFFDBD8D8);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color blackTemp = Color(0xff000000);

  Color get black26 => brightness == Brightness.dark ? white30 : Colors.black54;
  static const Color cardColor = Color(0xffFFFFFF);
}
