import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_testing/blocs/register/register_bloc.dart';
import 'package:flutter_hive_testing/blocs/register/register_event.dart';
import 'package:flutter_hive_testing/blocs/register/register_state.dart';
import 'package:flutter_hive_testing/models/person.dart';
import 'package:flutter_hive_testing/view/screens/login/login_screen.dart';
import 'package:country_picker/country_picker.dart';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();

  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode ageFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode numberFocusNode = FocusNode();
  final FocusNode dateOfBirthFocusNode = FocusNode();
  final FocusNode nationalityFocusNode = FocusNode();

  Gender _selectedGender = Gender.male;
  final List<Gender> _genders = [
    Gender.male,
    Gender.female,
  ];

  bool _obscurePassword = true;

  final RegExp _nameRegExp = RegExp(r'^[A-Za-z]{2,20}$');
  final RegExp _emailRegExp = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
  final RegExp _passwordRegExp = RegExp(r'^.{8,32}$');

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });

    // Automatically revert the password visibility after 1 second
    Timer(const Duration(seconds: 1), () {
      setState(() {
        _obscurePassword = true;
      });
    });
  }

  Gender _parseGender(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      default:
        return Gender.male;
    }
  }

  DateTime? _parseDateOfBirth(String dateOfBirth) {
    try {
      return DateFormat('dd-MM-yyyy').parse(dateOfBirth);
    } catch (e) {
      print('Error parsing date: $e');
      return null;
    }
  }

  void _showCountryPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      onSelect: (Country country) {
        setState(() {
          nationalityController.text = country.displayName;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            bottom: 200,
            child: CustomPaint(
              size: const Size(double.infinity, double.infinity),
              painter: CenteredBackgroundShapePainter(),
            ),
          ),
          BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              } else if (state is RegisterFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            child: BlocBuilder<RegisterBloc, RegisterState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  controller: ScrollController(),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30.0),
                        Center(
                          child: Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.purpleAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextField(
                          controller: usernameController,
                          focusNode: usernameFocusNode,
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
                            hintText: 'Username',
                          ),
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(nameFocusNode),
                        ),
                        const SizedBox(height: 10.0),
                        TextField(
                          controller: nameController,
                          focusNode: nameFocusNode,
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
                            hintText: 'Name',
                          ),
                          onEditingComplete: () =>
                              FocusScope.of(context).requestFocus(ageFocusNode),
                        ),
                        const SizedBox(height: 10.0),
                        TextField(
                          controller: ageController,
                          focusNode: ageFocusNode,
                          keyboardType: TextInputType.number,
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
                            hintText: 'Age',
                          ),
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(emailFocusNode),
                        ),
                        const SizedBox(height: 10.0),
                        TextField(
                          controller: emailController,
                          focusNode: emailFocusNode,
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
                            hintText: 'Email',
                          ),
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(passwordFocusNode),
                        ),
                        const SizedBox(height: 10.0),
                        TextField(
                          controller: passwordController,
                          focusNode: passwordFocusNode,
                          obscureText: _obscurePassword,
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
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                          ),
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(numberFocusNode),
                        ),
                        const SizedBox(height: 10.0),
                        TextField(
                          controller: numberController,
                          focusNode: numberFocusNode,
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
                            hintText: 'Number',
                          ),
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(dateOfBirthFocusNode),
                        ),
                        const SizedBox(height: 10.0),
                        DropdownButtonFormField<Gender>(
                          value: _selectedGender,
                          onChanged: (Gender? newValue) {
                            setState(() {
                              _selectedGender = _parseGender(newValue!.name);
                            });
                          },
                          items: _genders.map((Gender gender) {
                            return DropdownMenuItem<Gender>(
                              value: gender,
                              child: Text(gender
                                  .toString()
                                  .split('.')
                                  .last
                                  .capitalize()),
                            );
                          }).toList(),
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
                            hintText: 'Gender',
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        GestureDetector(
                          onTap: _selectDateOfBirth,
                          child: AbsorbPointer(
                            child: TextField(
                              controller: dateOfBirthController,
                              focusNode: dateOfBirthFocusNode,
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
                                hintText: 'Date of Birth',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        GestureDetector(
                          onTap: _showCountryPicker,
                          child: AbsorbPointer(
                            child: TextField(
                              controller: nationalityController,
                              focusNode: nationalityFocusNode,
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
                                hintText: 'Nationality',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize:
                                  Size(size.width * 0.7, size.height * 0.06),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              // Basic validation before submitting
                              if (usernameController.text.isEmpty ||
                                  nameController.text.isEmpty ||
                                  ageController.text.isEmpty ||
                                  emailController.text.isEmpty ||
                                  passwordController.text.isEmpty ||
                                  numberController.text.isEmpty ||
                                  dateOfBirthController.text.isEmpty ||
                                  nationalityController.text.isEmpty) {
                                // Show a snackbar or alert dialog to notify the user to fill all fields
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Please fill all fields')),
                                );
                                return;
                              }

                              // Ensure dateOfBirth is valid
                              final parsedDateOfBirth =
                                  _parseDateOfBirth(dateOfBirthController.text);
                              if (parsedDateOfBirth == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Please enter a valid date of birth')),
                                );
                                return;
                              }

                              // If all validations pass, trigger the registration event
                              BlocProvider.of<RegisterBloc>(context).add(
                                RegisterUser(
                                  username: usernameController.text,
                                  name: nameController.text,
                                  age: int.tryParse(ageController.text) ?? 0,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  number: numberController.text,
                                  gender: _selectedGender.name,
                                  dateOfBirth: parsedDateOfBirth,
                                  nationality: nationalityController.text,
                                ),
                              );
                            },
                            child: const Text('Register'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDateOfBirth() async {
    final DateTime now = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: now,
    );

    if (pickedDate != null) {
      setState(() {
        dateOfBirthController.text = _formatDate(pickedDate);
        ageController.text = getAge(pickedDate.year).toString();
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  int getAge(int yearOfBirth) {
    var currentYear = DateTime.now().year;
    return currentYear - yearOfBirth;
  }
}

extension StringCapitalize on String {
  String capitalize() {
    if (isEmpty) return '';
    return this[0].toUpperCase() + substring(1);
  }
}
