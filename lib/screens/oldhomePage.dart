// import 'package:flutter/material.dart';
// import 'package:flutter_hive_testing/models/person.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// class HomePage extends StatelessWidget {
//   final Person user;

//   const HomePage({super.key, required this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Page'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 20.0),
//             Text(
//               'Welcome, ${user.name}!',
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10.0),
//             Text(
//               'Username: ${user.username}',
//               style: const TextStyle(fontSize: 18),
//             ),
//             const SizedBox(height: 20.0),
//           ],
//         ),
//       ),
//     );
//   }
// }
