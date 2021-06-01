import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:steps_tracker/core/service/sharedpreferences/sharedpref_service.dart';
import 'package:steps_tracker/feature/login/data/models/user_model.dart';

part 'data_user_event.dart';
part 'data_user_state.dart';

class DataUserBloc extends Bloc<DataUserEvent, DataUserState> {
  final SharedPrefService _sharedPrefService;
  DataUserBloc({
    required SharedPrefService sharedPrefService,
  })  : _sharedPrefService = sharedPrefService,
        super(DataUserInitial());

  @override
  Stream<DataUserState> mapEventToState(
    DataUserEvent event,
  ) async* {
    if (event is GetDataUser) {
      yield DataUserLoadingState();
      try {
        final item = await _sharedPrefService.getDataUser();
        yield DataUserSuccessState(item);
      } catch (e) {
        yield DataUserErrorState();
      }
    }
  }
}
