part of 'detailuser_bloc.dart';

abstract class DetailuserState extends Equatable {
  const DetailuserState();

  @override
  List<Object> get props => [];
}

class DetailuserInitial extends DetailuserState {}

class DetailUserLoading extends DetailuserState {}

class DetailUserSuccess extends DetailuserState {
  final UserModel item;

  DetailUserSuccess(this.item);

  @override
  List<Object> get props => [item];
}

class DetailUserErrorLoading extends DetailuserState {
  final String errorMesage;

  DetailUserErrorLoading(this.errorMesage);
}
