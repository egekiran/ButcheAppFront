import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  TransactionList({super.key});

  final List<Transaction> transactions = [
    Transaction(
        date: 'Bugün',
        description: 'Starbucks',
        amount: '-113.00₺',
        isIncome: false),
    Transaction(
        date: 'Bugün',
        description: 'Burger King',
        amount: '-187.00₺',
        isIncome: false),
    Transaction(
        date: 'Dün',
        description: 'Harçlık',
        amount: '+3000.00₺',
        isIncome: true),
    Transaction(
        date: '09.06.2024',
        description: 'Burger King',
        amount: '-187.00₺',
        isIncome: false),
  ];

  void _showTransactionDetails(BuildContext context, Transaction transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(
                color: transaction.isIncome ? Colors.green : Colors.red,
                width: 3,
              )),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lexend'),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Tarih: ${transaction.date}',
                  style: TextStyle(fontFamily: 'Lexend'),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Miktar: ${transaction.amount}',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: transaction.isIncome ? Colors.green : Colors.red,
                  ),
                ),
                SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      // Silme işlemini burada gerçekleştirin
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Sil',
                      style: TextStyle(fontFamily: 'Lexend'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: transactions.map((transaction) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: GestureDetector(
            onTap: () => _showTransactionDetails(context, transaction),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  width: 3,
                  color: transaction.isIncome ? Colors.green : Colors.red,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transaction.date,
                          style: TextStyle(
                              color: Colors.grey, fontFamily: 'Lexend'),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          transaction.description,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lexend'),
                        ),
                      ],
                    ),
                    Text(
                      transaction.amount,
                      style: TextStyle(
                        color: transaction.isIncome ? Colors.green : Colors.red,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class Transaction {
  final String date;
  final String description;
  final String amount;
  final bool isIncome;

  Transaction({
    required this.date,
    required this.description,
    required this.amount,
    required this.isIncome,
  });
}
