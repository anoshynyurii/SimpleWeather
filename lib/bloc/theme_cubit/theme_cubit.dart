import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_weather/repositories/local_repo.dart';
import 'package:simple_weather/theme/theme.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final ThemeRepo _repo;

  ThemeCubit(this._repo) : super(ThemeState(mode: _repo.getTheme()));

  void setTheme(ThemeModeEnum mode) {
    _repo.saveTheme(mode);
    emit(state.copyWith(mode: mode));
  }

  void changeTheme() {
    final newMode = state.mode == ThemeModeEnum.light
        ? ThemeModeEnum.dark
        : ThemeModeEnum.light;

    setTheme(newMode);
  }
}
