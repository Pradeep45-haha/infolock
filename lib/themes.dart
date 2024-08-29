import 'package:flutter/material.dart';

//primary padding
const primaryPadding =  EdgeInsets.all(16.0);


//floating action button and icons theme
final floatingButtonStyle = ButtonStyle(
  backgroundColor: WidgetStatePropertyAll(Colors.purple[400]),
);
const floatingIconColor = Colors.white;
const floatingIconSize = 42.0;

//Text theme
const titleTextStyle = TextStyle(color: Colors.white, fontSize: 18);
const userTextStyle = TextStyle(color: Colors.black, fontSize: 16);

//user info tile
const tileRadius = BorderRadius.all(Radius.circular(12));
final tileCardShadowColor = Colors.purple[100]!;
const tileContainerColor = Colors.white;
final tileContainerBorder =
    Border.all(color: Colors.purple, width: 1, style: BorderStyle.solid);

//padding
const nameTextPadding = EdgeInsets.all(8.0);
const ageTextPadding = EdgeInsets.only(left: 16.0, bottom: 8, top: 8, right: 8);



//text form field 
const textFormFieldBorderRadius = BorderRadius.all(Radius.circular(12));