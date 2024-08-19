import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_testing/blocs/History/history_bloc.dart';
import 'package:flutter_hive_testing/blocs/History/history_event.dart';
import 'package:flutter_hive_testing/blocs/History/history_state.dart';
import 'package:flutter_hive_testing/models/credit_card_info.dart';
import 'package:flutter_hive_testing/models/history_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CardHistoryAndDetailsScreen extends StatelessWidget {
  final Box<CreditCardInfo> boxCard = Hive.box<CreditCardInfo>('creditCardBox');

  @override
  Widget build(BuildContext context) {
    // Fetch the first card for demonstration purposes
    final CreditCardInfo? card =
        boxCard.getAt(0); // Change the index or key as needed

    return Scaffold(
      appBar: AppBar(
        title: Text('Card Details'),
        backgroundColor: Colors.purple[300],
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) =>
            HistoryBloc(historyBox: Hive.box<History>('transaction_history'))
              ..add(LoadHistory()), // Load history when the screen is opened
        child: Container(
          color: Colors.white, // White background for the entire screen
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: card != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Modern Credit Card Display with Light Purple Theme
                      GestureDetector(
                        onTap: () {
                          // You can add a feature to show more details or flip the card
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.purple[200]!,
                                Colors.purple[400]!
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.purple[100]!,
                                blurRadius: 15.0,
                                offset: Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '**** **** **** ${card.cardNumber.substring(card.cardNumber.length - 4)}',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Icon(
                                    Icons.credit_card,
                                    color: Colors.white70,
                                    size: 28,
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    card.cardHolderName.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    card.expiryDate,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'CVV: ${card.cvvCode}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white38,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),

                      // Generate Random Transaction Button
                      ElevatedButton(
                        onPressed: () {
                          context
                              .read<HistoryBloc>()
                              .generateRandomHistory(card.cardHolderName);
                        },
                        child: Text('Generate Random Transaction'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.purple[400], // Background color
                        ),
                      ),

                      SizedBox(height: 20),

                      // Transaction History Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Transaction History',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[400],
                            ),
                          ),
                          Icon(
                            Icons.filter_list,
                            color: Colors.purple[400],
                          ), // Future feature: Filter transactions
                        ],
                      ),
                      SizedBox(height: 10),

                      // Transaction History List with Light Purple Theme
                      Expanded(
                        child: BlocBuilder<HistoryBloc, HistoryState>(
                          builder: (context, state) {
                            if (state is HistoryLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is HistoryLoaded) {
                              if (state.histories.isEmpty) {
                                return Center(
                                  child: Text(
                                    'No transactions found.',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.purple[300]),
                                  ),
                                );
                              }
                              return ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: state.histories.length,
                                itemBuilder: (context, index) {
                                  final history = state.histories[index];
                                  return GestureDetector(
                                    onTap: () {
                                      // Navigate to a detailed view of the transaction if needed
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              TransactionDetailScreen(
                                                  history: history),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.purple[100]!,
                                            blurRadius: 10.0,
                                            offset: Offset(0, 6),
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16.0, vertical: 10.0),
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.purple[300],
                                          child: Icon(Icons.swap_horiz,
                                              color: Colors.white),
                                        ),
                                        title: Text(
                                          '${history.sender} → ${history.receiver}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.purple[400],
                                          ),
                                        ),
                                        subtitle: Text(
                                          'Amount: \$${history.amount}\nDate: ${history.dateTime}',
                                          style: TextStyle(
                                              color: Colors.grey[600]),
                                        ),
                                        isThreeLine: true,
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (state is HistoryError) {
                              return Center(child: Text(state.message));
                            } else {
                              return Center(
                                  child: Text(
                                      'No transaction history available.'));
                            }
                          },
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Text(
                      'No card details available.',
                      style: TextStyle(fontSize: 18, color: Colors.purple[300]),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class TransactionDetailScreen extends StatelessWidget {
  final History history;

  const TransactionDetailScreen({Key? key, required this.history})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Details'),
        backgroundColor: Colors.purple[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'From: ${history.sender}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'To: ${history.receiver}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Amount: \$${history.amount}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${history.dateTime}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
