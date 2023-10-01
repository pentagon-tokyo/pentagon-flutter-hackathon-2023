import 'package:flutter/material.dart';

enum MyColors {
  white(color: Color(0xffffffff)),
  black(color: Color(0xff080808)),
  offWhite(color: Color(0xfffffffB)),
  primary(color: Color(0xff3B2D53)),
  beige(color: Color(0xffFEFCF3)),
  grey100(color: Color(0xffF3F3F3)),
  grey200(color: Color(0xffE5E5E5)),
  grey150(color: Color(0xffEFEFEF)),
  grey300(color: Color(0xff91989F)),
  grey600(color: Color(0xff787878)),
  grey800(color: Color(0xff252525)),
  grey900(color: Color(0xff1C1C1C)),
  stateDanger(color: Color(0xffFD3B2A)),
  secondaryMain(color: Color(0xffCFC19F)),
  secondaryLight(color: Color(0xffB4A582)),
  bgPop(color: Color(0x66000000)),
  bgBlur(color: Color(0x3D000000)),
  bgPopup(color: Color(0x28000000)),
  bgIcon(color: Color(0x14000000)),
  actionLink(color: Color(0xff007AFF)),
  opacity(color: Color(0x00000000)),
  ;

  const MyColors({required this.color});
  final Color color;

  static MaterialColor get materialColor =>
      convertSingleMaterialColor(MyColors.primary.color.value);

  static MaterialColor convertSingleMaterialColor(int value) {
    return MaterialColor(
      value,
      <int, Color>{
        50: Color(value),
        100: Color(value),
        200: Color(value),
        300: Color(value),
        400: Color(value),
        500: Color(value),
        600: Color(value),
        700: Color(value),
        800: Color(value),
        900: Color(value),
      },
    );
  }
}
