import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:structure/models/shop-app/categories_model.dart';
import 'package:structure/models/shop-app/home-model.dart';
import 'package:structure/modules/shop_app/categories/categories-screen.dart';
import 'package:structure/modules/shop_app/favorites/favorites-screen.dart';
import 'package:structure/modules/shop_app/products/products-screen.dart';
import 'package:structure/modules/shop_app/settings/settings-screen.dart';
import 'package:structure/shared/components/constants.dart';
import 'package:structure/shared/network/end_point.dart';
import 'package:structure/shared/network/remote/dio_helper.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottum(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categorieModel;
  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categorieModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      printFullText(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }
}
