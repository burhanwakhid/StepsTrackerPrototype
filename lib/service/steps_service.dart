import 'dart:async';

import 'package:pedometer/pedometer.dart';
import 'package:steps_tracker/feature/login/data/datasource/firestore_data_source.dart';

class StepsService {
  final FirestoreDataSource dataSource;

  late Stream<StepCount> _stepController;

  StreamController<UserStep> test = StreamController<UserStep>.broadcast();

  StepsService(this.dataSource) {
    _stepController = Pedometer.stepCountStream;

    _stepController.listen(onStepCount).onError(onStepCountError);
  }

  Stream<UserStep> get stepsStream => test.stream;

  void onStepCount(StepCount event) {
    print(event);
    dataSource.updateTotalStep(event.steps);
    test.add(UserStep(event.steps.toString()));
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    test.add(UserStep('Step Count not available'));
  }
}

class UserStep {
  final String steps;

  UserStep(this.steps);
}
