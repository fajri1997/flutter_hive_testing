import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_testing/blocs/login/login_bloc.dart';
import 'package:flutter_hive_testing/blocs/login/login_state.dart';
import 'package:flutter_hive_testing/blocs/profile/profile_bloc.dart';
import 'package:flutter_hive_testing/models/person.dart';
import 'package:flutter_hive_testing/models/credit_card_info.dart';
import 'package:flutter_hive_testing/view/Widgets/CreditCardDisplayWidget.dart';
import 'package:flutter_hive_testing/view/Widgets/widgets_card.dart';
import 'package:flutter_hive_testing/view/Widgets/bank_account_type_widget.dart'; // Import the widget
import 'package:flutter_hive_testing/view/screens/CreditCard/card_history_screen.dart';
import 'package:flutter_hive_testing/view/screens/profile/profile.dart';
import 'package:flutter_hive_testing/view/screens/login/login_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../main.dart';

class HomePage extends StatefulWidget {
  final Person user;

  const HomePage({super.key, required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _currentPage = 0;

  late final List<CreditCardInfo> creditCards;

  @override
  void initState() {
    super.initState();
    // Retrieve all saved CreditCardInfo objects from the box
    creditCards = boxCard.values.toSet().toList().cast<CreditCardInfo>();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

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
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple[200]!, Colors.purple[400]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
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
                      child: ProfilePage(userId: widget.user.username),
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SettingsScreen(),
                //   ),
                // );
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20.0),
              Text(
                'Welcome, ${widget.user.name}!',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              Text(
                'Username: ${widget.user.username}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20.0),

              // PageView with dots indicator
              Column(
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: PageView.builder(
                        controller: _pageController,
                        onPageChanged: (index) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                        itemCount: creditCards.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: CreditCardDisplayWidget(
                              user: widget.user,
                              cardIndex: index,
                              dotsButtonVisible: creditCards.isNotEmpty,
                              creditCardInfo: creditCards[index],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  // Dots Indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(creditCards.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          _pageController.jumpToPage(index);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          width: _currentPage == index ? 12.0 : 8.0,
                          height: _currentPage == index ? 12.0 : 8.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _currentPage == index
                                ? Colors.blueAccent
                                : Colors.grey,
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Center(
                child: Visibility(
                  visible: creditCards.isEmpty,
                  child: ClickableCard(),
                ),
              ),
              const SizedBox(height: 20.0),
              // Add the BankAccountTypeWidget here
              BankAccountTypeWidget(
                onAccountTypeSelected: (accountType) {
                  // Handle account type selection
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selected: $accountType')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    // Clear the user data from Hive
    BlocProvider.of<LoginBloc>(context).emit(LoginInitial());
    // Navigate to the LoginPage and clear the navigation stack
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
      (r) => false,
    );
  }
}
