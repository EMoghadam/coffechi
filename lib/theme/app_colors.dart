import 'package:flutter/material.dart';

class AppColors {
  // Primary colors
  static const Color primary = Color(0xfff3742b);
  static const Color secondary = Color(0xffb83a14);
  static const Color blueDark = Color(0xFF231650);
  static const Color tertiary = Color(0xFFfed172);
  static const Color transparent = Colors.transparent;
  static const Color background = Color(0xfffafafa);
  static const Color textDark = Color(0xff333333);
  static const Color textLight = Color(0xff757575);

  // Status colors
  static const Color success = Color(0xff45D275);
  static const Color error = Color(0xffFF4848);
  static const Color warning = Color(0xffF8DE56);
  static const Color navy = Color(0xff000957);

  // pallet primery
  static const Color p1 = Color(0xffeceeff);
  static const Color p2 = Color(0xffdde1ff);
  static const Color p3 = Color(0xffc2c7ff);
  static const Color p4 = Color(0xff9ca1ff);
  static const Color p5 = Color(0xff7a75ff);
  static const Color p6 = Color(0xff7766ff);
  static const Color p7 = Color(0xff5a36f5);
  static const Color p8 = Color(0xff4e2ad8);
  static const Color p9 = Color(0xff362689);
  static const Color p10 = Color(0xff221650);

  // Black shades
  static const Color black = Color(0xff0c0101);
  static const Color blackSolid = Color(0xff0C0101);
  static const Color black1 = Color(0xff373737);
  static const Color black2 = Color(0xff4d4d4d);
  static const Color black3 = Color(0xff636363);
  static const Color black4 = Color(0xff7a7a7a);
  static const Color black5 = Color(0xff909090);
  static const Color black6 = Color(0xffa6a6a6);
  static const Color black7 = Color(0xffbcbcbc);
  static const Color black8 = Color(0xffd3d3d3);
  static const Color black9 = Color(0xffe9e9e9);
  static const Color black10 = Color(0xfcf1eee9);

  static const Color white = Color(0xffffffff);

  // Colors with opacity (can't be const because depends on method)
  static final Color boxFill = white.withOpacity(0.25);


  // Gradients
  static const LinearGradient purpleLinearGradient = LinearGradient(
    colors: [
      Color(0xff0A0229),
      Color(0xff420171),
      Color(0xff9104C5),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkBlackGradient = LinearGradient(
    colors: [
      Color.fromRGBO(55, 55, 55, 0.3),
      Color.fromRGBO(12, 1, 1, 0.3),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkBackgroundGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromRGBO(80, 0, 0, 0.3),
      Color.fromRGBO(80, 0, 0, 0.2),
    ],
  );

  static const LinearGradient blueRedGradient = LinearGradient(
    colors: [
      Color(0xffa624ef),
      Color(0xff7766ff),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient createGradientFromColor(Color baseColor) {
    Color lighten(Color color, [double amount = 0.05]) {
      // فقط کمی روشن‌تر
      final hsl = HSLColor.fromColor(color);
      final hslLight =
          hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));
      return hslLight.toColor();
    }

    return LinearGradient(
      colors: [
        lighten(baseColor, 0.05), // خیلی ملایم روشن‌تر
        baseColor,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

}
