import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_testing/blocs/profile/profile_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'blocs/register/register_bloc.dart';
import 'blocs/login/login_bloc.dart';
import 'blocs/home/home_bloc.dart';
import 'models/person.dart';
import 'screens/login/login_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/register/register_screen.dart'; // Import the RegisterPage

late Box<Person> boxPerson;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  boxPerson = await Hive.openBox<Person>(
      'personBox'); // Ensure the type is specified here
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterBloc(personBox: boxPerson),
        ),
        BlocProvider(
          create: (context) => LoginBloc(personBox: boxPerson),
        ),
        BlocProvider(
          create: (context) => HomeBloc(personBox: boxPerson),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(personBox: boxPerson),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hive BLoC Example',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: boxPerson.isEmpty
            ? const SelectionPage() // Show selection page when no user data exists
            : HomePage(user: boxPerson.get('user') ?? Person()),
      ),
    );
  }
}

class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: const Text('Register'),
            ),
            const SizedBox(height: 20), // Add space between buttons
            ElevatedButton(
              onPressed: () {
                // Navigate directly to the HomePage
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        HomePage(user: boxPerson.get('user') ?? Person()),
                  ),
                );
              },
              child: const Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
