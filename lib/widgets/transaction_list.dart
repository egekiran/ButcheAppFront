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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16.0),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
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
                      transactions[index].date,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      transactions[index].description,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  transactions[index].amount,
                  style: TextStyle(
                    color: transactions[index].isIncome
                        ? Colors.green
                        : Colors.red,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
