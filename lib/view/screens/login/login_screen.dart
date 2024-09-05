import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_testing/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

// Import your BLoC components
import 'package:flutter_hive_testing/blocs/home/home_bloc.dart';
import 'package:flutter_hive_testing/blocs/home/home_event.dart';
import 'package:flutter_hive_testing/blocs/login/login_bloc.dart';
import 'package:flutter_hive_testing/blocs/login/login_event.dart';
import 'package:flutter_hive_testing/blocs/login/login_state.dart';

// Import your models and screens
import 'package:flutter_hive_testing/models/person.dart';
import 'package:flutter_hive_testing/view/screens/home/home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
                const SnackBar(content: Text('User not found.')),
              );
            }
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Stack(
          children: [
            Positioned.fill(
              bottom: 200,
              child: CustomPaint(
                size: const Size(double.infinity, double.infinity),
                painter: CenteredBackgroundShapePainter(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50.0),
                  Center(
                    child: Text(
                      'WELCOME BACK!',
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 200.0),
                  Center(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.purpleAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      //add a radius to the border of the text field and no color to borderside
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),

                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Username',
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(size.width * 0.7, size.height * 0.06),
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
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
                  ),
                ],
              ),
            ),
          ],
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

class CenteredBackgroundShapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.purple.withOpacity(0.06) // Adjust color and opacity
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.25,
      size.width * 0.5,
      size.height * 0.4,
    );
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.55,
      size.width,
      size.height * 0.4,
    );
    path.lineTo(size.width, size.height * 0.6);
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.75,
      size.width * 0.5,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.45,
      0,
      size.height * 0.6,
    );
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
