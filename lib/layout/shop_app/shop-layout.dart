import 'package:flutter/material.dart';
import 'package:structure/modules/shop_app/login/shop_login_screen.dart';
import 'package:structure/shared/components/components.dart';
import 'package:structure/shared/network/local/cahce_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Salla',
        ),
      ),
      body: TextButton(
        onPressed: () {
          CacheHelper.remouveData(
            key: 'token',
          ).then((value) {
            navigateAndFinish(
              context,
              ShopLoginScreen(),
            );
          });
        },
        child: Text('SIGN OUT'),
      ),
    );
  }
}
