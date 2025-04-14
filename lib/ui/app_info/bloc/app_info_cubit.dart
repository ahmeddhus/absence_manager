import 'package:absence_manager/ui/app_info/bloc/app_info_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppInfoCubit extends Cubit<AppInfoState> {
  AppInfoCubit() : super(AppInfoInitial());

  Future<void> loadAppInfo() async {
    final info = await PackageInfo.fromPlatform();
    emit(AppInfoLoaded('v${info.version}'));
  }
}
