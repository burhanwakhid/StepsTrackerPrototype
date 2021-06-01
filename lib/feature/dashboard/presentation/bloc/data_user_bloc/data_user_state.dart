part of 'data_user_bloc.dart';

abstract class DataUserState extends Equatable {
  const DataUserState();

  @override
  List<Object> get props => [];
}

class DataUserInitial extends DataUserState {}

class DataUserLoadingState extends DataUserInitial {}

class DataUserSuccessState extends DataUserInitial {
  final UserModel item;

  DataUserSuccessState(this.item);

  @override
  List<Object> get props => [item];
}

class DataUserErrorState extends DataUserInitial {}
