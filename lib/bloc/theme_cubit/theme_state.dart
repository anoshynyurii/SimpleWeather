part of 'theme_cubit.dart';

class ThemeState {
  final ThemeModeEnum mode;

  const ThemeState({required this.mode});

  ThemeState copyWith({ThemeModeEnum? mode}) {
    return ThemeState(mode: mode ?? this.mode);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || other is ThemeState && mode == other.mode;
  }
  @override
  int get hashCode => mode.hashCode;
}
