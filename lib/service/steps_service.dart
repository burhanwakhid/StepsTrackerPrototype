import 'dart:async';

import 'package:pedometer/pedometer.dart';

class StepsService {
  late Stream<StepCount> _stepController;

  StreamController<UserStep> test = StreamController<UserStep>.broadcast();

  StepsService() {
    _stepController = Pedometer.stepCountStream;

    _stepController.listen(onStepCount).onError(onStepCountError);
  }

  Stream<UserStep> get stepsStream => test.stream;

  void onStepCount(StepCount event) {
    print(event);
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
