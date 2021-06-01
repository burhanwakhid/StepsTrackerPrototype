import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steps_tracker/di/injection.dart';
import 'package:steps_tracker/feature/dashboard/presentation/pages/dashboard_page.dart';
import 'package:steps_tracker/feature/login/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:steps_tracker/service/steps_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginBloc loginBloc = sl<LoginBloc>();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userSteps = Provider.of<UserStep>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('login'),
      ),
      body: BlocProvider(
        create: (context) => loginBloc,
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'input your name'),
                ),
              ),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  print('cuk');
                  print(state);
                  if (state is LoginSuccesState) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => DashboardPage()));
                  } else if (state is LoginErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)));
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: (state is LoginLoadingState)
                        ? null
                        : () {
                            print('object');
                            loginBloc.add(GetLoginUser(nameController.text,
                                int.parse(userSteps.steps)));
                          },
                    child: (state is LoginLoadingState)
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text('Login'),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
