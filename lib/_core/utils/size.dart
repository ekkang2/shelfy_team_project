import 'package:flutter/cupertino.dart';

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getDrawerWidth(BuildContext context) {
  return getScreenWidth(context) * 0.65;
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
