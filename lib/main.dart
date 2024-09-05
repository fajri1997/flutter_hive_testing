import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_testing/blocs/CreditCard/credicardBloc.dart';
import 'package:flutter_hive_testing/blocs/History/history_bloc.dart';
import 'package:flutter_hive_testing/blocs/profile/profile_bloc.dart';
import 'package:flutter_hive_testing/blocs/sendAmount/send_amount_bloc.dart';
import 'package:flutter_hive_testing/blocs/settings/settings_bloc.dart';
import 'package:flutter_hive_testing/models/credit_card_info.dart';
import 'package:flutter_hive_testing/models/history_hive.dart';
import 'package:flutter_hive_testing/models/settings.dart';
import 'package:flutter_hive_testing/utils/history.box.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'blocs/register/register_bloc.dart';
import 'blocs/login/login_bloc.dart';
import 'blocs/home/home_bloc.dart';
import 'blocs/settings/settings_state.dart';
import 'models/person.dart';
import 'models/send_amount.dart';
import 'view/screens/login/login_screen.dart';
import 'view/screens/home/home_screen.dart';
import 'view/screens/register/register_screen.dart'; // Import the RegisterPage

late Box<Person> boxPerson;
late Box<CreditCardInfo> boxCard;
late Box<History> boxHistory;
late Box<SettingsModel> boxSettings;
late Box<SendAmount> boxSendAmount;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  Hive.registerAdapter(CreditCardInfoAdapter());
  Hive.registerAdapter(HistoryAdapter());
  Hive.registerAdapter(SettingsModelAdapter());

  Hive.registerAdapter(SendAmountAdapter());

  boxPerson = await Hive.openBox<Person>('personBox');
  boxCard = await Hive.openBox<CreditCardInfo>('creditCardBox');
  boxHistory = await Hive.openBox<History>("History");
  boxSendAmount = await Hive.openBox<SendAmount>("SendAmount");
  boxSettings = await Hive.openBox<SettingsModel>('settingsBox');

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
        BlocProvider(
          create: (context) => CreditCardBloc(creditCardBox: boxCard),
        ),
        BlocProvider(
          create: (context) => HistoryBloc(historyBox: boxHistory),
        ),
        BlocProvider(
          create: (context) => SettingsBloc(boxSettings),
        ),
        BlocProvider(
          create: (context) => SendAmountBloc(boxSendAmount),
        ),
      ],
      child: BlocBuilder<SettingsBloc, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.settings.isDarkMode
                ? ThemeData.dark()
                : ThemeData.light(),
            debugShowCheckedModeBanner: false,
            title: 'Hive BLoC Example',
            home: boxPerson.isEmpty
                ? const SelectionPage()
                : HomePage(user: boxPerson.get('user') ?? Person()),
          );
        },
      ),
    );
  }
}

class SelectionPage extends StatelessWidget {
  const SelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(size.height * 0.4),
        child: AppBar(
          backgroundColor: Colors.purple,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.elliptical(size.width, 100),
            ),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(200),
            child: Padding(
              padding: EdgeInsets.only(bottom: 28.0),
              child: Text(
                'Welcome',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                foregroundColor: Colors.white,
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
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
              style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xffED3EF7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
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
              style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width * 0.7, size.height * 0.06),
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xffBF2EF0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
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
