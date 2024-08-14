import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_testing/blocs/login/login_bloc.dart';
import 'package:flutter_hive_testing/blocs/login/login_state.dart';
import 'package:flutter_hive_testing/blocs/profile/profile_bloc.dart';
import 'package:flutter_hive_testing/models/person.dart';
import 'package:flutter_hive_testing/screens/profile/profile.dart';
import 'package:flutter_hive_testing/screens/login/login_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../main.dart'; // Ensure you import the LoginPage

class HomePage extends StatelessWidget {
  final Person user;

  const HomePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => ProfileBloc(personBox: boxPerson),
                      child: ProfilePage(userId: user.username),
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Add navigation to the Settings page here
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Logout'),
              onTap: () {
                _logout(context); // Call the logout function
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Text(
              'Welcome, ${user.name}!',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Username: ${user.username}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20.0),
            // Additional UI elements
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    // Clear the user data from Hive
    // boxPerson.clear();
    // ignore: invalid_use_of_visible_for_testing_member
    BlocProvider.of<LoginBloc>(context).emit(LoginInitial());
    // Navigate to the LoginPage and clear the navigation stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (r) => false,
    );
  }
}
