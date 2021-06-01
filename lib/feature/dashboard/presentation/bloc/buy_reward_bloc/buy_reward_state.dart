part of 'buy_reward_bloc.dart';

abstract class BuyRewardState extends Equatable {
  const BuyRewardState();

  @override
  List<Object> get props => [];
}

class BuyRewardInitial extends BuyRewardState {}

class BuyRewardLoading extends BuyRewardState {}

class BuyRewardSucces extends BuyRewardState {}

class BuyRewardError extends BuyRewardState {
  final String error;

  BuyRewardError(this.error);

  @override
  List<Object> get props => [error];
}
