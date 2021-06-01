part of 'list_reward_bloc.dart';

abstract class ListRewardState extends Equatable {
  const ListRewardState();

  @override
  List<Object> get props => [];
}

class ListRewardInitial extends ListRewardState {}

class ListRewardLoading extends ListRewardState {}

class ListRewardSucces extends ListRewardState {
  final List<ListRewardModel> item;

  ListRewardSucces(this.item);

  @override
  List<Object> get props => [item];
}

class ListRewardError extends ListRewardState {
  final String error;

  ListRewardError(this.error);

  @override
  List<Object> get props => [error];
}
