import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:structure/shared/network/local/cahce_helper.dart';

part 'modetheme_state.dart';

class ModethemeCubit extends Cubit<ModethemeState> {
  ModethemeCubit() : super(ModethemeInitial());

  static ModethemeCubit get(context) => BlocProvider.of(context);
  bool isDark = true;

  void changeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(NewsModeChange());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(NewsModeChange());
      });
    }
  }
}
