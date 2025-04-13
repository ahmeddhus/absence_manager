// Repositories
import 'package:absence_manager/core/network/http_client.dart';
import 'package:absence_manager/core/network/network_checker.dart';
import 'package:absence_manager/data/repositories/absence/absence_repository.dart';
import 'package:absence_manager/data/repositories/absence/absence_repository_impl.dart';
import 'package:absence_manager/data/repositories/member/member_repository.dart';
import 'package:absence_manager/data/repositories/member/member_repository_impl.dart';
import 'package:absence_manager/data/services/api/absence_remote_service.dart';
import 'package:absence_manager/data/services/api/member_remote_service.dart';
import 'package:absence_manager/data/services/local/absence_local_service.dart';
// Services
import 'package:absence_manager/data/services/local/member_local_service.dart';
import 'package:absence_manager/domain/use_cases/get_absences_with_members_use_case.dart';
import 'package:absence_manager/ui/absence/bloc/absence_bloc.dart';
import 'package:absence_manager/utils/i_cal_exporter_factory.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> setupLocator() async {
  // Core
  sl.registerLazySingleton(() => HttpClient());
  sl.registerLazySingleton(() => NetworkChecker());

  // Remote Services
  sl.registerLazySingleton(() => AbsenceRemoteService(sl()));
  sl.registerLazySingleton(() => MemberRemoteService(sl()));
  sl.registerLazySingleton(() => AbsenceLocalService());
  sl.registerLazySingleton(() => MemberLocalService());

  // Repositories
  sl.registerLazySingleton<AbsenceRepository>(
    () => AbsenceRepositoryImpl(
      remoteService: sl<AbsenceRemoteService>(),
      localService: sl<AbsenceLocalService>(),
      network: sl<NetworkChecker>(),
    ),
  );
  sl.registerLazySingleton<MemberRepository>(
    () => MemberRepositoryImpl(
      remoteService: sl<MemberRemoteService>(),
      localService: sl<MemberLocalService>(),
      network: sl<NetworkChecker>(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(
    () => GetAbsencesWithMembersUseCase(
      absenceRepository: sl<AbsenceRepository>(),
      memberRepository: sl<MemberRepository>(),
    ),
  );

  //Bloc
  sl.registerFactory(
    () => AbsencesBloc(sl<GetAbsencesWithMembersUseCase>(), createAbsenceExporter()),
  );
}
