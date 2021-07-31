import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:structure/layout/shop_app/cubit/shop_cubit.dart';
import 'package:structure/modules/shop_app/search/search-screen.dart';
import 'package:structure/shared/components/components.dart';
import 'package:structure/shared/components/constants.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'ShopApp',
              style: Theme.of(context).textTheme.headline5,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(
                    context,
                    SearchScreen(),
                  );
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  signOut(context);
                },
                icon: Icon(Icons.logout),
              ),
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],

//----------------bottom_navy_bar_style---------------------

          bottomNavigationBar: BottomNavyBar(
            selectedIndex: cubit.currentIndex,
            showElevation: true, // use this to remove appBar's elevation
            onItemSelected: (index) {
              cubit.changeBottum(index);
            },
            items: [
              BottomNavyBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                activeColor: Colors.blue,
              ),
              BottomNavyBarItem(
                  icon: Icon(Icons.apps),
                  title: Text('Categories'),
                  activeColor: Colors.blue),
              BottomNavyBarItem(
                  icon: Icon(Icons.favorite),
                  title: Text('Favorites'),
                  activeColor: Colors.blue),
              BottomNavyBarItem(
                  icon: Icon(Icons.settings),
                  title: Text('Settings'),
                  activeColor: Colors.blue),
            ],
          ),

//----------------simple-bottom_navigation_bar_style---------------------

          // bottomNavigationBar: BottomNavigationBar(
          //   currentIndex: cubit.currentIndex,
          //   onTap: (index) {
          //     cubit.changeBottum(index);
          //   },
          //   items: [
          //     BottomNavigationBarItem(
          //       label: 'Home',
          //       icon: Icon(
          //         Icons.home,
          //       ),
          //     ),
          //     BottomNavigationBarItem(
          //       label: 'Categories',
          //       icon: Icon(
          //         Icons.apps,
          //       ),
          //     ),
          //     BottomNavigationBarItem(
          //       label: 'Favorites',
          //       icon: Icon(
          //         Icons.favorite,
          //       ),
          //     ),
          //     BottomNavigationBarItem(
          //       label: 'Settings',
          //       icon: Icon(
          //         Icons.settings,
          //       ),
          //     ),
          //   ],
          // ),
        );
      },
    );
  }
}
