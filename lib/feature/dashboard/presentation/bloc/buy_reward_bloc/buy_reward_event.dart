part of 'buy_reward_bloc.dart';

abstract class BuyRewardEvent extends Equatable {
  const BuyRewardEvent();

  @override
  List<Object> get props => [];
}

class GetBuyReward extends BuyRewardEvent {
  final int price;

  GetBuyReward(this.price);

  @override
  List<Object> get props => [price];
}
