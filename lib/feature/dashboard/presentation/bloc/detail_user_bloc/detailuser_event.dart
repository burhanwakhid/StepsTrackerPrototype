part of 'detailuser_bloc.dart';

abstract class DetailuserEvent extends Equatable {
  const DetailuserEvent();

  @override
  List<Object> get props => [];
}

class GetDetailUser extends DetailuserEvent {}
