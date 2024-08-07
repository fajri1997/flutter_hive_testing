import 'package:flutter/material.dart';
import 'package:flutter_hive_testing/person.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:country_picker/country_picker.dart';
import 'package:intl/intl.dart';

late Box<Person> boxPerson;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  boxPerson = await Hive.openBox<Person>('personBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hive',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

  String? _errorText;

  Gender? _parseGender(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      default:
        return null;
    }
  }

  DateTime? _parseDateOfBirth(String dateOfBirth) {
    try {
      return DateTime.parse(dateOfBirth);
    } catch (e) {
      return null;
    }
  }

  void addPerson() {
    final username = usernameController.text;
    final name = nameController.text;
    final age = int.tryParse(ageController.text);
    final email = emailController.text;
    final password = passwordController.text;
    final number = numberController.text;
    final gender = _selectedGender;
    final dateOfBirth = _parseDateOfBirth(dateOfBirthController.text);
    final nationality = nationalityController.text;

    if (username.isNotEmpty &&
        name.isNotEmpty &&
        age != null &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        number.isNotEmpty &&
        dateOfBirth != null &&
        nationality.isNotEmpty) {
      final person = Person(
        username: username,
        name: name,
        age: age,
        email: email,
        password: password,
        number: number,
        gender: gender,
        dateOfBirth: dateOfBirth,
        nationality: nationality,
      );
      boxPerson.add(person);
      print("THIS IS PERSON ->>>> ${boxPerson.values.last?.age}");
      _clearAllControllers();
      setState(() {
        _errorText = null;
      });
    } else {
      setState(() {
        _errorText = 'Please fill all fields correctly.';
      });
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

  void _clearAllControllers() {
    usernameController.clear();
    nameController.clear();
    ageController.clear();
    emailController.clear();
    passwordController.clear();
    numberController.clear();
    dateOfBirthController.clear();
    nationalityController.clear();
    _selectedGender = Gender.male;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Hive Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0),
            TextField(
              controller: usernameController,
              focusNode: usernameFocusNode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Username',
              ),
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(nameFocusNode),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: nameController,
              focusNode: nameFocusNode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
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
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Age',
              ),
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(emailFocusNode),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: emailController,
              focusNode: emailFocusNode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
              ),
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(passwordFocusNode),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: passwordController,
              focusNode: passwordFocusNode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Password',
              ),
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(numberFocusNode),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: numberController,
              focusNode: numberFocusNode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Number',
              ),
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(dateOfBirthFocusNode),
            ),
            const SizedBox(height: 10.0),
            DropdownButtonFormField<Gender>(
              value: _selectedGender,
              onChanged: (Gender? newValue) {
                setState(() {
                  _selectedGender = newValue!;
                });
              },
              items: _genders.map((Gender gender) {
                return DropdownMenuItem<Gender>(
                  value: gender,
                  child: Text(gender.toString().split('.').last.capitalize()),
                );
              }).toList(),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nationality',
                  ),
                ),
              ),
            ),
            if (_errorText != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  _errorText!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: addPerson,
              child: const Text('Add Person'),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: boxPerson.listenable(),
                builder: (context, Box<Person> box, _) {
                  if (box.isEmpty) {
                    return const Center(child: Text('No people added.'));
                  } else {
                    return ListView.builder(
                      itemCount: box.length,
                      itemBuilder: (context, index) {
                        final person = box.get(index);
                        return ListTile(
                          title: Text(person?.name ?? 'No Name'),
                          subtitle: Text('Age: ${person?.age ?? 0}'),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
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

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        dateOfBirthController.text = _formatDate(pickedDate);
        ageController.text = getAge(pickedDate.year).toString();
      });
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  // dont foget to try somthing
  int getAge(int yearOfBirth) {
    var currentYear = DateTime.now().year;
    return currentYear - yearOfBirth;
  }
}

extension StringCapitalize on String {
  String capitalize() {
    if (this.isEmpty) return '';
    return this[0].toUpperCase() + substring(1);
  }
}
