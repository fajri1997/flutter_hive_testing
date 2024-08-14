// // i have login.dart will cheack users from boxPerson so will have 2 filed username and password
// // if user right and password right will say say succsed
// //if user right and password is wrong will say password is wrong
// // if user wrong will say user dont rigester

// import 'package:flutter/material.dart';
// import 'package:flutter_hive_testing/screens/homePage.dart';

// import 'package:flutter_hive_testing/models/person.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   late Box<Person> boxPerson;
//   String? _errorText;

//   @override
//   void initState() {
//     super.initState();
//     initBox();
//   }

//   Future<void> initBox() async {
//     boxPerson = Hive.box('personBox');
//   }

//   void _login() {
//     final username = usernameController.text;
//     final password = passwordController.text;

//     var user = boxPerson.get('user');

//     if (user != null &&
//         user.username == username &&
//         user.password == password) {
//       _errorText = "success";
//       print("User exists ${boxPerson.values}");

//       // Navigate to the HomePage upon successful login
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => HomePage(user: user)),
//       );
//     } else {
//       setState(() {
//         _errorText = "Error";
//       });
//       print("User doesn't exist ${boxPerson.values}");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Login'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 10.0),
//             TextField(
//               controller: usernameController,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Username',
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             TextField(
//               controller: passwordController,
//               obscureText: true,
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: 'Password',
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             if (_errorText != null)
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 10.0),
//                 child: Text(
//                   _errorText!,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ),
//             const SizedBox(height: 10.0),
//             ElevatedButton(
//               onPressed: _login,
//               child: const Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
