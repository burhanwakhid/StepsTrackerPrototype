import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:steps_tracker/feature/login/data/datasource/firestore_data_source.dart';
import 'package:steps_tracker/feature/login/data/models/list_reward_model.dart';

part 'list_reward_event.dart';
part 'list_reward_state.dart';

class ListRewardBloc extends Bloc<ListRewardEvent, ListRewardState> {
  final FirestoreDataSource _dataSource;
  ListRewardBloc({
    required FirestoreDataSource dataSource,
  })  : _dataSource = dataSource,
        super(ListRewardInitial());

  @override
  Stream<ListRewardState> mapEventToState(
    ListRewardEvent event,
  ) async* {
    if (event is GetListReward) {
      yield ListRewardLoading();
      try {
        final item = await _dataSource.getListReward();
        yield ListRewardSucces(item);
      } catch (e) {
        yield ListRewardError(e.toString());
      }
    }
  }
}
