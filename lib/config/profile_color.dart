import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';


const kSpacingUnit = 10;
const kDarkPrimaryColor = Color(0xFF212121);
const kDarkSecondaryColor = Color(0xFF373737);
const kLightPrimaryColor = Color(0xFFFFFFFF);
const kLightSecondaryColor = Color(0xFFF3F7FB);
const kAccentColor = Color(0xFFFFC107);


const kGrey1Color = Color(0xFFF3F3F3);
const kGrey2Color = Color(0xFFA9A8A8);
const kBlue1Color = Color(0xFF40BEEE);
const kBlue2Color = Color(0xFFD9F2FC);
const kRedColor = Color(0xFFED5568);
const kYellowColor = Color(0xFFFFB755);
const kGreenColor = Color(0xFFDBF3E8);
const kGreen2Color = Color(0xFF58c697);

/*
var kTitleStyle = GoogleFonts.lato(
  // ignore: prefer_const_constructors
  textStyle: TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  ),
);
var kSubtitleStyle = GoogleFonts.lato(
  // ignore: prefer_const_constructors
  textStyle: TextStyle(
    fontSize: 16.0,
  ),
);
var kButtonStyle = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 13.0,
    color: Colors.white,
  ),
);
var kCategoryStyle = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
);
var kRatingStyle = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w400,
    color: kGrey2Color,
  ),
);
var kSubtitle2Style = GoogleFonts.lato(
  textStyle: TextStyle(
    fontSize: 14.0,
  ),
);


*/

final kTitleTextStyle = TextStyle(
  //fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.7),
  fontWeight: FontWeight.w600,
);

final kCaptionTextStyle = TextStyle(
  //fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.3),
  fontWeight: FontWeight.w200,
);

final kButtonTextStyle = TextStyle(
  //fontSize: ScreenUtil().setSp(kSpacingUnit.w * 1.5),
  fontWeight: FontWeight.w400,
  color: kDarkPrimaryColor,
);



final kDarkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'SFProText',
  primaryColor: kDarkPrimaryColor,
  canvasColor: kDarkPrimaryColor,
  backgroundColor: kDarkSecondaryColor,
  accentColor: kAccentColor,
  iconTheme: ThemeData.dark().iconTheme.copyWith(
    color: kLightSecondaryColor,
  ),
  textTheme: ThemeData.dark().textTheme.apply(
    fontFamily: 'SFProText',
    bodyColor: kLightSecondaryColor,
    displayColor: kLightSecondaryColor,
  ),
);

final kLightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'SFProText',
  primaryColor: kLightPrimaryColor,
  canvasColor: kLightPrimaryColor,
  iconTheme: ThemeData.light().iconTheme.copyWith(
    color: kDarkSecondaryColor,
  ),
  backgroundColor: kLightSecondaryColor,
  textTheme: ThemeData.light().textTheme.apply(
    fontFamily: 'SFProText',
    bodyColor: kDarkSecondaryColor,
    displayColor: kDarkSecondaryColor,
  ), colorScheme: ColorScheme.fromSwatch().copyWith(secondary: kAccentColor),
);