part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {
  final String errorMessage;

  LoginErrorState(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class LoginSuccesState extends LoginState {
  final SignInSignUpResult item;

  LoginSuccesState(this.item);

  @override
  List<Object> get props => [item];
}
