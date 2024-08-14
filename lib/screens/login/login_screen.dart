import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Import your BLoC components
import 'package:flutter_hive_testing/blocs/home/home_bloc.dart';
import 'package:flutter_hive_testing/blocs/home/home_event.dart';
import 'package:flutter_hive_testing/blocs/login/login_bloc.dart';
import 'package:flutter_hive_testing/blocs/login/login_event.dart';
import 'package:flutter_hive_testing/blocs/login/login_state.dart';

// Import your models and screens
import 'package:flutter_hive_testing/models/person.dart';
import 'package:flutter_hive_testing/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          print(state);
          if (state is LoginSuccess) {
            final person =
                Hive.box<Person>('personBox').get(usernameController.text);
            if (person != null) {
              BlocProvider.of<HomeBloc>(context).add(
                LoadUserData(userId: usernameController.text),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(user: person),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('User not found.')),
              );
            }
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Username',
                ),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                ),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  print('object');
                  final username = usernameController.text;
                  final password = passwordController.text;

                  if (username.isNotEmpty && password.isNotEmpty) {
                    BlocProvider.of<LoginBloc>(context).add(
                      LoginUser(
                        username: username,
                        password: password,
                      ),
                    );
                    setState(() {});
                  } else {
                    print('object');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please fill in both fields'),
                      ),
                    );
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
