import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'modetheme_state.dart';

class ModethemeCubit extends Cubit<ModethemeState> {
  ModethemeCubit() : super(ModethemeInitial());

  static ModethemeCubit get(context) => BlocProvider.of(context);
  bool isDark = false;
  changeMode() {
    isDark = !isDark;
    emit(NewsModeChange());
  }
}
