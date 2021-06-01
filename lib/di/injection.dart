import 'package:get_it/get_it.dart';
import 'package:steps_tracker/core/service/sharedpreferences/sharedpref_service.dart';
import 'package:steps_tracker/feature/dashboard/di_module/dashboard_injection.dart';
import 'package:steps_tracker/feature/login/di_module/login_injection.dart';
import 'package:steps_tracker/service/steps_service.dart';

final sl = GetIt.instance;

Future<void> init() async {
  loginModule(sl);
  dashboardInjection(sl);

  //! core
  sl.registerLazySingleton<StepsService>(() => StepsService(sl()));
  sl.registerLazySingleton<SharedPrefService>(() => SharedPrefService());
}
