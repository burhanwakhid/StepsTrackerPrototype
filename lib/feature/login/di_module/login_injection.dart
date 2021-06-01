import 'package:get_it/get_it.dart';
import 'package:steps_tracker/feature/login/data/datasource/firebas_auth.dart';
import 'package:steps_tracker/feature/login/data/datasource/firestore_data_source.dart';
import 'package:steps_tracker/feature/login/data/datasource/firestore_transaction_data_source.dart';
import 'package:steps_tracker/feature/login/presentation/bloc/login_bloc/login_bloc.dart';

Future<void> loginModule(GetIt sl) async {
  //bloc
  sl.registerFactory(
    () => LoginBloc(
      authService: sl(),
      sharedPrefService: sl(),
    ),
  );

  // data source
  sl.registerLazySingleton<AuthService>(() => AuthService(sl()));
  sl.registerLazySingleton<FirestoreDataSource>(
      () => FirestoreDataSource(sl()));

  sl.registerLazySingleton<FirestoreTransactionDataSource>(
      () => FirestoreTransactionDataSource(sl()));
}
