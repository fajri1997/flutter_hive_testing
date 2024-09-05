import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_testing/blocs/sendAmount/send_amount_bloc.dart';
import 'package:flutter_hive_testing/blocs/sendAmount/send_amount_event.dart';
import 'package:flutter_hive_testing/blocs/sendAmount/send_amount_state.dart';
import 'package:flutter_hive_testing/models/credit_card_info.dart';
import 'package:flutter_hive_testing/models/person.dart';
import 'package:flutter_hive_testing/models/send_amount.dart';
import 'package:flutter_hive_testing/view/Widgets/CreditCardDisplayWidget.dart';
import 'package:flutter_hive_testing/view/Widgets/bank_account_type_widget.dart';
import 'package:flutter_hive_testing/view/Widgets/widgets_card.dart';
import 'package:flutter_hive_testing/view/screens/CreditCard/CurrentPage.dart';

class EnterAmountScreen extends StatefulWidget {
  const EnterAmountScreen({super.key});

  @override
  State<EnterAmountScreen> createState() => _EnterAmountScreenState();
}

class _EnterAmountScreenState extends State<EnterAmountScreen> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int grpValue = 0;
  String sendingTo = 'Current';
  String sendingFrom = 'Card';
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Send Money',
          style: TextStyle(),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Send From: ',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: sendingFrom,
                onChanged: (String? newValue) {
                  setState(() {
                    sendingFrom = newValue!;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: 'Card',
                    child: Text('Card'),
                  ),
                  DropdownMenuItem(
                    value: 'Account',
                    child: Text('Account'),
                  ),
                ],
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
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
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black54
                      : Colors.grey[200],
                  hintText: 'Gender',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Send To: ',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: sendingTo,
                onChanged: (String? newValue) {
                  setState(() {
                    sendingTo = newValue!;
                  });
                },
                items: const [
                  DropdownMenuItem(
                    value: 'Saving',
                    child: Text('Saving'),
                  ),
                  DropdownMenuItem(
                    value: 'Current',
                    child: Text('Current'),
                  ),
                ],
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).brightness == Brightness.light
                      ? Colors.black
                      : Colors.white,
                ),
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
                  fillColor: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black54
                      : Colors.grey[200],
                  hintText: 'Gender',
                ),
              ),
              const SizedBox(height: 20),
              // Amount Input
              const Text(
                'Enter Amount',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Currency Selector
                    Text(
                      'KWD',
                      style: TextStyle(fontSize: 28),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontSize: 28),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '0.00',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Spacer(),

              // Send Button
              BlocBuilder<SendAmountBloc, SendAmountState>(
                builder: (context, state) => Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle send money action
                      context.read<SendAmountBloc>().add(
                            SendButtonPressed(
                              amount: (amountController.text),
                            ),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(size.width * 0.7, size.height * 0.06),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Send Money',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Cancel Button
              Center(
                child: TextButton(
                  onPressed: () {
                    // Handle cancel action
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.purpleAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
