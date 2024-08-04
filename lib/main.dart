import 'package:flutter/material.dart';
import 'package:flutter_hive_testing/person.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  void addPerson() {
    final name = nameController.text;
    final age = int.tryParse(ageController.text);

    if (name.isNotEmpty && age != null) {
      final person = Person(name: name, age: age);
      boxPerson.add(person);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      appBar: AppBar(
        title: const Text('Hive Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Name',
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Age',
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
}
