import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure/layout/news-app/cubit/newsapp%20cubit/newsapp_cubit.dart';

import 'package:structure/layout/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:structure/layout/shop_app/shop-layout.dart';
import 'package:structure/modules/shop_app/login/shop_login_screen.dart';

import 'package:structure/shared/network/local/cahce_helper.dart';
import 'package:structure/shared/network/remote/bloc-observer.dart';
import 'package:structure/shared/network/remote/dio_helper.dart';
import 'package:structure/shared/styles/themes.dart';

import 'layout/news-app/cubit/modetheme cubit/modetheme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  String? token = CacheHelper.sharedPreferences!.getString('token');
  Widget widget;

  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardngScreen();
  }

  runApp(
    MyApp(
      isDark: isDark,
      startWidget: widget,
    ),
  );
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  bool? isDark;
  Widget startWidget;
  MyApp({
    this.isDark,
    required this.startWidget,
  });
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getSciences(),
        ),
        BlocProvider(
          create: (context) => ModethemeCubit()
            ..changeMode(
              fromShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<ModethemeCubit, ModethemeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ModethemeCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
