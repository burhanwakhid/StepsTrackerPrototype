import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:steps_tracker/feature/login/data/datasource/firestore_transaction_data_source.dart';

part 'buy_reward_event.dart';
part 'buy_reward_state.dart';

class BuyRewardBloc extends Bloc<BuyRewardEvent, BuyRewardState> {
  final FirestoreTransactionDataSource _dataSource;
  BuyRewardBloc({
    required FirestoreTransactionDataSource dataSource,
  })  : _dataSource = dataSource,
        super(BuyRewardInitial());

  @override
  Stream<BuyRewardState> mapEventToState(
    BuyRewardEvent event,
  ) async* {
    if (event is GetBuyReward) {
      yield BuyRewardLoading();
      try {
        await _dataSource.buyReward(event.price);
        yield BuyRewardSucces();
      } catch (e) {
        print(e.toString());
        yield BuyRewardError(e.toString());
      }
    }
  }
}
