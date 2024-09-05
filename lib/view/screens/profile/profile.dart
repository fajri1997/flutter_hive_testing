import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_testing/blocs/profile/profile_bloc.dart';
import 'package:flutter_hive_testing/blocs/profile/profile_event.dart';
import 'package:flutter_hive_testing/blocs/profile/profile_state.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({super.key, required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController numberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(LoadProfile(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.purpleAccent,
          ),
        ),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            emailController.text = state.person.email;
            numberController.text = state.person.number;

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: ${state.person.name}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Date of Birth: ${state.person.dateOfBirth != null ? DateFormat('dd-MM-yyyy').format(state.person.dateOfBirth!) : 'Not Available'}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: numberController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      labelText: 'Mobile Number',
                    ),
                  ),
                  const SizedBox(height: 20),
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
                        context.read<ProfileBloc>().add(
                              UpdateProfile(
                                email: emailController.text,
                                number: numberController.text,
                              ),
                            );
                      },
                      child: const Text('Save Changes'),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ProfileError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Something went wrong!'));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    numberController.dispose();
    super.dispose();
  }
}
