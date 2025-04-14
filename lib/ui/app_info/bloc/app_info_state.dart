sealed class AppInfoState {}

class AppInfoInitial extends AppInfoState {}

class AppInfoLoaded extends AppInfoState {
  final String version;
  AppInfoLoaded(this.version);
}
