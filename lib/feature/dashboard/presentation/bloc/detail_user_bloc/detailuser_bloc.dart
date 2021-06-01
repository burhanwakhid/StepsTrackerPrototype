import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:steps_tracker/feature/login/data/datasource/firestore_data_source.dart';
import 'package:steps_tracker/feature/login/data/models/user_model.dart';

part 'detailuser_event.dart';
part 'detailuser_state.dart';

class DetailuserBloc extends Bloc<DetailuserEvent, DetailuserState> {
  final FirestoreDataSource _dataSource;
  DetailuserBloc({
    required FirestoreDataSource dataSource,
  })  : _dataSource = dataSource,
        super(DetailuserInitial());

  @override
  Stream<DetailuserState> mapEventToState(
    DetailuserEvent event,
  ) async* {
    if (event is GetDetailUser) {
      yield DetailUserLoading();
      try {
        final item = await _dataSource.getDetailUser();
        yield DetailUserSuccess(item);
      } catch (e) {
        yield DetailUserErrorLoading(e.toString());
      }
    }
  }
}
