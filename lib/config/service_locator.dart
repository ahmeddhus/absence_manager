// Repositories
import 'package:absence_manager/data/repositories/absence/absence_repository.dart';
import 'package:absence_manager/data/repositories/absence/absence_repository_local.dart';
import 'package:absence_manager/data/repositories/member/member_repository.dart';
import 'package:absence_manager/data/repositories/member/member_repository_local.dart';
import 'package:absence_manager/data/services/local/local_absence_service.dart';
// Services
import 'package:absence_manager/data/services/local/local_json_loader.dart';
import 'package:absence_manager/data/services/local/local_member_service.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Core
  sl.registerLazySingleton(() => LocalJsonLoader());

  // Services
  sl.registerLazySingleton(() => LocalAbsenceService(sl()));
  sl.registerLazySingleton(() => LocalMemberService(sl()));

  // Repositories
  sl.registerLazySingleton<AbsenceRepository>(() => AbsenceLocalRepository(sl()));
  sl.registerLazySingleton<MemberRepository>(() => MemberLocalRepository(sl()));
}
