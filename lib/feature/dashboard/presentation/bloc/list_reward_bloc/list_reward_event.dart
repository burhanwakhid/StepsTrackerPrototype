part of 'list_reward_bloc.dart';

abstract class ListRewardEvent extends Equatable {
  const ListRewardEvent();

  @override
  List<Object> get props => [];
}

class GetListReward extends ListRewardEvent {}
