part of 'history_point_bloc.dart';

abstract class HistoryPointEvent extends Equatable {
  const HistoryPointEvent();

  @override
  List<Object> get props => [];
}

class GetHistoryPoint extends HistoryPointEvent {}
