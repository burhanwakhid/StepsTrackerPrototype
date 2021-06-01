import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/di/injection.dart';
import 'package:steps_tracker/feature/dashboard/presentation/bloc/data_user_bloc/data_user_bloc.dart';
import 'package:steps_tracker/feature/dashboard/presentation/bloc/detail_user_bloc/detailuser_bloc.dart';
import 'package:steps_tracker/feature/dashboard/presentation/pages/history_point_page.dart';
import 'package:steps_tracker/feature/dashboard/presentation/pages/list_item_reward_page.dart';
import 'package:steps_tracker/service/steps_service.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DataUserBloc userBloc = sl<DataUserBloc>();
  DetailuserBloc detailuserBloc = sl<DetailuserBloc>();

  @override
  Widget build(BuildContext context) {
    var userSteps = Provider.of<UserStep>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<DataUserBloc>(
          create: (context) => userBloc..add(GetDataUser()),
        ),
        BlocProvider<DetailuserBloc>(
          create: (context) => detailuserBloc..add(GetDetailUser()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('dashboard'),
        ),
        body: Column(
          children: [
            BlocBuilder<DataUserBloc, DataUserState>(
              builder: (context, state) {
                if (state is DataUserLoadingState) {
                  return Container();
                } else if (state is DataUserSuccessState) {
                  var steps =
                      int.parse(userSteps.steps) - state.item.initialStep;
                  return Column(
                    children: [
                      Text('login as: ${state.item.nama} / ${state.item.id}'),
                      Divider(),
                      Text('Total Steps anda:'),
                      Text('$steps'),
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
            Divider(),
            BlocBuilder<DetailuserBloc, DetailuserState>(
              builder: (context, state) {
                if (state is DetailUserLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is DetailUserSuccess) {
                  return Column(
                    children: [
                      Text('point: '),
                      Text(state.item.point.toString()),
                      ElevatedButton(
                        onPressed: () {
                          detailuserBloc.add(GetDetailUser());
                        },
                        child: Text('refresh point'),
                      ),
                    ],
                  );
                } else if (state is DetailUserErrorLoading) {
                  return Text('error');
                }
                return SizedBox.shrink();
              },
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => HistoryPointPage()));
                  },
                  child: Text('History Point'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ListRewardPage()));
                  },
                  child: Text('Pick Reward'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
