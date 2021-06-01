import 'package:get_it/get_it.dart';
import 'package:steps_tracker/feature/dashboard/presentation/bloc/buy_reward_bloc/buy_reward_bloc.dart';
import 'package:steps_tracker/feature/dashboard/presentation/bloc/data_user_bloc/data_user_bloc.dart';
import 'package:steps_tracker/feature/dashboard/presentation/bloc/detail_user_bloc/detailuser_bloc.dart';
import 'package:steps_tracker/feature/dashboard/presentation/bloc/history_point_bloc/history_point_bloc.dart';
import 'package:steps_tracker/feature/dashboard/presentation/bloc/list_reward_bloc/list_reward_bloc.dart';

Future<void> dashboardInjection(GetIt sl) async {
  sl.registerFactory(() => DataUserBloc(sharedPrefService: sl()));

  sl.registerFactory(() => DetailuserBloc(dataSource: sl()));

  sl.registerFactory(() => HistoryPointBloc(dataSource: sl()));

  sl.registerFactory(() => ListRewardBloc(dataSource: sl()));

  sl.registerFactory(() => BuyRewardBloc(dataSource: sl()));
}
