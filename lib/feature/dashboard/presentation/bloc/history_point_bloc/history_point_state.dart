part of 'history_point_bloc.dart';

abstract class HistoryPointState extends Equatable {
  const HistoryPointState();

  @override
  List<Object> get props => [];
}

class HistoryPointInitial extends HistoryPointState {}

class HistoryPointLoading extends HistoryPointState {}

class HistoryPointSuccess extends HistoryPointState {
  final List<HistoryPointModel> item;

  HistoryPointSuccess(this.item);

  @override
  List<Object> get props => [item];
}

class HistoryPointError extends HistoryPointState {
  final String error;

  HistoryPointError(this.error);

  @override
  List<Object> get props => [error];
}
