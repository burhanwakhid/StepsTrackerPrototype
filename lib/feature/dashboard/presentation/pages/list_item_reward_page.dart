import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/di/injection.dart';
import 'package:steps_tracker/feature/dashboard/presentation/bloc/buy_reward_bloc/buy_reward_bloc.dart';
import 'package:steps_tracker/feature/dashboard/presentation/bloc/list_reward_bloc/list_reward_bloc.dart';

class ListRewardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ListRewardBloc rewardBloc = sl<ListRewardBloc>();
    BuyRewardBloc buyRewardBloc = sl<BuyRewardBloc>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => rewardBloc..add(GetListReward()),
        ),
        BlocProvider<BuyRewardBloc>(create: (context) => buyRewardBloc)
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('list reward'),
        ),
        body: BlocBuilder<ListRewardBloc, ListRewardState>(
          builder: (context, state) {
            if (state is ListRewardLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ListRewardError) {
              return Text('error');
            } else if (state is ListRewardSucces) {
              return ListView.builder(
                itemCount: state.item.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(state.item[i].name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('from: ${state.item[i].from}'),
                            SizedBox(
                              width: 10,
                            ),
                            Text('price: ${state.item[i].price}'),
                          ],
                        ),
                        BlocConsumer<BuyRewardBloc, BuyRewardState>(
                          listener: (context, state) {
                            print(state);
                            if (state is BuyRewardSucces) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('success')));
                            } else if (state is BuyRewardError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(state.error)));
                            }
                          },
                          builder: (context, state2) {
                            return ElevatedButton(
                              onPressed: () {
                                buyRewardBloc
                                    .add(GetBuyReward(state.item[i].price));
                              },
                              child: Text('Buy'),
                            );
                          },
                        ),
                        Divider(),
                      ],
                    ),
                  );
                },
              );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
