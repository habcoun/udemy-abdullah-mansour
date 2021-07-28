part of 'shop_login_cubit.dart';

@immutable
abstract class ShopLoginState {}

class ShopLoginInitial extends ShopLoginState {}

class ShopLoginLoading extends ShopLoginState {}

class ShopLoginSucess extends ShopLoginState {
  final ShopLoginModel loginModel;

  ShopLoginSucess(this.loginModel);
}

class ShopLoginError extends ShopLoginState {
  final String error;

  ShopLoginError(this.error);
}

class ShopLoginChangePasswordVisibility extends ShopLoginState {}
