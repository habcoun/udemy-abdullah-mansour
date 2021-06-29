import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:structure/shared/network/local/cahce_helper.dart';

part 'modetheme_state.dart';

class ModethemeCubit extends Cubit<ModethemeState> {
  ModethemeCubit() : super(ModethemeInitial());

  static ModethemeCubit get(context) => BlocProvider.of(context);
  bool isDark = false;
  changeMode() {
    isDark = !isDark;
    CacheHelper.putData(value: isDark, key: 'isDark')
        .then((value) => emit(NewsModeChange()));
  }
}
