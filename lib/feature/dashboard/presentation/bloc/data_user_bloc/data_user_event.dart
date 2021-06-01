part of 'data_user_bloc.dart';

abstract class DataUserEvent extends Equatable {
  const DataUserEvent();

  @override
  List<Object> get props => [];
}

class GetDataUser extends DataUserEvent {}
