import 'package:flutter/material.dart';

import 'colors.dart';

const defaultTextStyle = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 15,
  color: Color(0xFF333333),
  fontFamily: 'Roboto',
  fontFamilyFallback: ['NotoSansJP'],
  letterSpacing: 0.5,
);

TextStyle textStyle(List<TextStyle> styles) {
  var mergedTextStyle = defaultTextStyle;
  for (final style in styles) {
    mergedTextStyle = mergedTextStyle.merge(style);
  }
  return mergedTextStyle;
}

const bold = TextStyle(fontWeight: FontWeight.bold);
const weight700 = TextStyle(fontWeight: FontWeight.w700);
const weight500 = TextStyle(fontWeight: FontWeight.w500);
const weight400 = TextStyle(fontWeight: FontWeight.w400);

const fontSize0 = TextStyle(fontSize: 0);
const fontSize10 = TextStyle(fontSize: 10);
const fontSize11 = TextStyle(fontSize: 11);
const fontSize12 = TextStyle(fontSize: 12);
const fontSize14 = TextStyle(fontSize: 14);
const fontSize15 = TextStyle(fontSize: 15);
const fontSize16 = TextStyle(fontSize: 16);
const fontSize18 = TextStyle(fontSize: 18);
const fontSize20 = TextStyle(fontSize: 20);
const fontSize22 = TextStyle(fontSize: 22);
const fontSize24 = TextStyle(fontSize: 24);
const fontSize28 = TextStyle(fontSize: 28);
const fontSize32 = TextStyle(fontSize: 32);
const fontSize34 = TextStyle(fontSize: 34);
const fontSize40 = TextStyle(fontSize: 40);

const black00 = TextStyle(color: colorTextBlack00);
const black11 = TextStyle(color: colorTextBlack11);
const black0E = TextStyle(color: colorTextBlack0E);
const black33 = TextStyle(color: colorTextBlack33);
const gray99 = TextStyle(color: colorTextGray99);
const gray66 = TextStyle(color: colorTextGray66);
const gray7A = TextStyle(color: colorTextGray7A);
const white = TextStyle(color: colorWhite);
const red = TextStyle(color: colorTextRed);

const primaryText = TextStyle(color: colorPrimaryText);
//const secondaryText = TextStyle(color: colorSecondaryText);
//const alertText = TextStyle(color: colorAlertText);
//const placeholderText = TextStyle(color: colorPlaceholder);
//const accentText = TextStyle(color: colorAccent);

const underline = TextStyle(decoration: TextDecoration.underline);
