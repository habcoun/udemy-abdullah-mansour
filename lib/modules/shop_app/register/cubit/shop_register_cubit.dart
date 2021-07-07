import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'shop_register_state.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterState> {
  ShopRegisterCubit() : super(ShopRegisterInitial());
}
