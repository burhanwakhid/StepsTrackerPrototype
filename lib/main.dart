import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:steps_tracker/service/steps_service.dart';

import 'package:steps_tracker/di/injection.dart' as di;
import 'di/injection.dart';
import 'feature/login/presentation/pages/login_page.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider(
      create: (context) => sl<StepsService>().stepsStream,
      initialData: UserStep('0'),
      child: MaterialApp(
        title: 'My Siis',
        home: LoginPage(),
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
