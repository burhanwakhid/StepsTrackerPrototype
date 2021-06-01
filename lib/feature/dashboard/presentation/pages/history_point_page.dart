import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/di/injection.dart';
import 'package:steps_tracker/feature/dashboard/presentation/bloc/history_point_bloc/history_point_bloc.dart';

class HistoryPointPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HistoryPointBloc historyPointBloc = sl<HistoryPointBloc>();
    return BlocProvider(
      create: (context) => historyPointBloc..add(GetHistoryPoint()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('history point'),
        ),
        body: BlocBuilder<HistoryPointBloc, HistoryPointState>(
          builder: (context, state) {
            if (state is HistoryPointLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HistoryPointError) {
              return Text('error');
            } else if (state is HistoryPointSuccess) {
              return ListView.builder(
                itemCount: state.item.length,
                itemBuilder: (context, i) {
                  if (state.item[i].point != 0) {
                    return ListTile(
                      title: state.item[i].point < 0
                          ? Text(state.item[i].point.toString() + ' point')
                          : Text(
                              '+' + state.item[i].point.toString() + ' point'),
                      subtitle:
                          Text(state.item[i].createdAt.toDate().toString()),
                    );
                  }
                  return SizedBox.shrink();
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
