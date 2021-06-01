import 'package:firebase_auth/firebase_auth.dart';
import 'package:steps_tracker/feature/login/data/datasource/firestore_data_source.dart';
import 'package:steps_tracker/feature/login/data/models/user_model.dart';

class AuthService {
  final FirestoreDataSource dataSource;

  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthService(this.dataSource);

  Future<SignInSignUpResult> signIn(String nama, int steps) async {
    try {
      UserCredential result = await _firebaseAuth.signInAnonymously();

      UserModel userModel =
          await this.dataSource.getUser(result.user!.uid, nama, steps);

      // return SignInSignUpResult(user: userModel);
      print('result: ${result.user!.uid}');

      return SignInSignUpResult(user: userModel);
    } catch (e) {
      print('dff');
      print(e.toString());
      return SignInSignUpResult(message: e.toString());
      // throw e.toString();
    }
  }
}

class SignInSignUpResult {
  final UserModel? user;
  final String? message;

  SignInSignUpResult({this.user, this.message});
}
