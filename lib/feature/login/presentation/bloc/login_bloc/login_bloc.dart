import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:steps_tracker/core/service/sharedpreferences/sharedpref_service.dart';
import 'package:steps_tracker/feature/login/data/datasource/firebas_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService _authService;
  final SharedPrefService _sharedPrefService;

  LoginBloc({
    required AuthService authService,
    required SharedPrefService sharedPrefService,
  })  : _authService = authService,
        _sharedPrefService = sharedPrefService,
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is GetLoginUser) {
      print('object3');
      yield LoginLoadingState();
      try {
        final data = await _authService.signIn(event.nama, event.steps);
        print('lolo');
        print(data.user!.nama);
        await _sharedPrefService.setDataUser(data.user!);
        yield LoginSuccesState(data);
      } catch (e) {
        print(e.toString());
        yield LoginErrorState(e.toString());
      }
    }
  }
}
