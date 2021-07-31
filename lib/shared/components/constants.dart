import 'package:flutter/material.dart';
import 'package:structure/modules/shop_app/login/shop_login_screen.dart';
import 'package:structure/shared/network/local/cahce_helper.dart';

import 'components.dart';

const defaultColor = Colors.blue;

void signOut(context) {
  CacheHelper.remouveData(
    key: 'token',
  ).then((value) {
    navigateAndFinish(
      context,
      ShopLoginScreen(),
    );
  });
}

void printFullText(String text) {
  final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

String token = '';
