import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hive_testing/blocs/History/history_bloc.dart';
import 'package:flutter_hive_testing/blocs/History/history_event.dart';
import 'package:flutter_hive_testing/blocs/History/history_state.dart';
import 'package:flutter_hive_testing/models/credit_card_info.dart';
import 'package:flutter_hive_testing/models/history_hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class CardHistoryAndDetailsScreen extends StatefulWidget {
  final int cardIndex;
  const CardHistoryAndDetailsScreen({super.key, required this.cardIndex});

  @override
  State<CardHistoryAndDetailsScreen> createState() =>
      _CardHistoryAndDetailsScreenState();
}

class _CardHistoryAndDetailsScreenState
    extends State<CardHistoryAndDetailsScreen> {
  final Box<CreditCardInfo> boxCard = Hive.box<CreditCardInfo>('creditCardBox');

  @override
  void initState() {
    super.initState();
  }

  int generateRandom = 1;
  @override
  Widget build(BuildContext context) {
    final CreditCardInfo? card = boxCard.getAt(widget.cardIndex);

    if (generateRandom == 1) {
      context.read<HistoryBloc>().generateRandomHistory(card!.cardHolderName);
    }

    Future.delayed(
      const Duration(seconds: 1),
      () {
        generateRandom = 0;
        setState(() {});
      },
    );
    var isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Details'),
        backgroundColor: Colors.purple[300],
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) =>
            HistoryBloc(historyBox: Hive.box<History>('History'))
              ..add(LoadHistory()),
        child: Container(
          color: isDarkTheme ? Colors.black : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: card != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {},
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
                                offset: const Offset(0, 8),
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
                                    style: const TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      letterSpacing: 2.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.credit_card,
                                    color: Colors.white70,
                                    size: 28,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    card.cardHolderName.toUpperCase(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    card.expiryDate,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'CVV: ${card.cvvCode}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white38,
                                  ),
                                ),
                              ),
                              const Text(
                                'Balance:',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const Text(
                                '\ 1200 KWD',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // // Generate Random Transaction Button
                      // ElevatedButton(
                      //   onPressed: () {
                      //     context
                      //         .read<HistoryBloc>()
                      //         .generateRandomHistory(card.cardHolderName);
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor:
                      //         Colors.purple[400], // Background color
                      //   ),
                      //   child: const Text('Generate Random Transaction'),
                      // ),

                      const SizedBox(height: 20),

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
                      const SizedBox(height: 10),

                      // Transaction History List with Light Purple Theme
                      Expanded(
                        child: BlocBuilder<HistoryBloc, HistoryState>(
                          builder: (context, state) {
                            if (state is HistoryLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
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

                              // Calculate the actual number of items considering month headers
                              final itemCount = state.histories.length +
                                  (state.histories.length ~/ 10);

                              // if (state.histories.isEmpty) {
                              if (generateRandom == 1) {
                                context
                                    .read<HistoryBloc>()
                                    .generateRandomHistory(card.cardHolderName);
                              }

                              // }

                              return ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: itemCount,
                                itemBuilder: (context, index) {
                                  // Calculate the index for the actual history items
                                  final historyIndex = index - (index ~/ 11);

                                  // Insert a month header before every 10th transaction
                                  if (index % 11 == 0 &&
                                      historyIndex < state.histories.length) {
                                    // Display the month header
                                    final monthDate =
                                        state.histories[historyIndex].dateTime;
                                    final monthName =
                                        "${getMonthName(monthDate.month)} ${monthDate.year}"; // Convert to "Month YYYY"

                                    // Get the date for the month header
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        monthName,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.purple[400],
                                        ),
                                      ),
                                    );
                                  }

                                  // Display the transaction history item
                                  if (historyIndex < state.histories.length) {
                                    final history =
                                        state.histories[historyIndex];
                                    return GestureDetector(
                                      onTap: () {
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
                                          color: isDarkTheme
                                              ? Colors.black87
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.purple[100]!,
                                              blurRadius: 10.0,
                                              offset: const Offset(0, 6),
                                            ),
                                          ],
                                        ),
                                        child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 16.0,
                                                  vertical: 10.0),
                                          leading: CircleAvatar(
                                            backgroundColor: Colors.purple[300],
                                            child: const Icon(Icons.swap_horiz,
                                                color: Colors.white),
                                          ),
                                          title: Text(
                                            history.isIn
                                                ? '${history.sender} → ${history.receiver}'
                                                : history.receiver,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.purple[400],
                                            ),
                                          ),
                                          subtitle: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Amount: ',
                                                style: TextStyle(
                                                    color: Colors.grey[600]),
                                              ),
                                              Text(
                                                history.isIn ? '+' : '-',
                                                style: TextStyle(
                                                  color: history.isIn
                                                      ? Colors.green
                                                      : Colors.red,
                                                ),
                                              ),
                                              Text(
                                                ' \$${history.amount}\n',
                                                style: TextStyle(
                                                  color: history.isIn
                                                      ? Colors.green
                                                      : Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: Text(
                                            'Date: ${history.dateTime}',
                                            style: TextStyle(
                                                color: Colors.grey[600]),
                                          ),
                                          isThreeLine: true,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox
                                        .shrink(); // Return an empty widget if out of range
                                  }
                                },
                              );
                            } else if (state is HistoryError) {
                              return Center(child: Text(state.message));
                            } else {
                              return const Center(
                                  child: Text(
                                      'No transaction history available.'));
                            }
                          },
                        ),
                      )
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

  const TransactionDetailScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        backgroundColor: Colors.purple[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'From: ${history.sender}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'To: ${history.receiver}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Amount:  ${history.amount} KWD',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Date: ${history.dateTime}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

String getMonthName(int month) {
  const monthNames = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];
  return monthNames[month - 1];
}
