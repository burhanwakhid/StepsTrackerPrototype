import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker/service/steps_service.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (context) => StepsService().stepsStream,
      initialData: UserStep('0'),
      child: MaterialApp(
        title: 'My Siis',
        home: Hehe(),
      ),
    );
  }
}

class Hehe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userSteps = Provider.of<UserStep>(context);
    return Scaffold(
      body: Center(child: Text(userSteps.steps)),
    );
  }
}
