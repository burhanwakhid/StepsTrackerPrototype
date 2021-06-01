part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class GetLoginUser extends LoginEvent {
  final String nama;
  final int steps;

  GetLoginUser(this.nama, this.steps);

  @override
  List<Object> get props => [nama];
}
