import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:steps_tracker/feature/login/data/datasource/firestore_data_source.dart';
import 'package:steps_tracker/feature/login/data/models/history_point_model.dart';

part 'history_point_event.dart';
part 'history_point_state.dart';

class HistoryPointBloc extends Bloc<HistoryPointEvent, HistoryPointState> {
  final FirestoreDataSource _dataSource;
  HistoryPointBloc({
    required FirestoreDataSource dataSource,
  })  : _dataSource = dataSource,
        super(HistoryPointInitial());

  @override
  Stream<HistoryPointState> mapEventToState(
    HistoryPointEvent event,
  ) async* {
    if (event is GetHistoryPoint) {
      yield HistoryPointLoading();
      try {
        final item = await _dataSource.getHistoryPoint();
        yield HistoryPointSuccess(item);
      } catch (e) {
        yield HistoryPointError(e.toString());
      }
    }
  }
}
