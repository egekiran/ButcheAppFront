import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import '../models/Transaction.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final List<Transaction> _transactions = [];
  final storage = const FlutterSecureStorage();
  bool _loading = true;
  bool _showMore = false;

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _deleteTransaction(String transactionId) async {
    final token = await storage.read(key: 'accessToken');
    const host = 'https://butchebackendapi.azurewebsites.net/';
    final path = 'api/Transactions/DeleteTransaction/$transactionId';

    try {
      final response = await http.delete(
        Uri.parse('$host$path'),
        headers: {
          'Authorization': 'bearer $token',
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          _transactions.removeWhere((tx) => tx.transactionId == transactionId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction deleted successfully.')),
        );
        print('Transaction deleted successfully!');
      } else {
        print(
            'Delete transaction error: ${response.statusCode}, ${response.body}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Üzgünüz'),
              content: const Text(
                  'İşlemi silerken bir hata oluştu. Daha sonra tekrar deneyin.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Tamam'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Exception occurred while deleting transaction: $e');
    }
  }

  Future<void> _fetchTransactions() async {
    final token = await storage.read(key: 'accessToken');
    const host = 'https://butchebackendapi.azurewebsites.net/';
    const path = 'api/Transactions/GetAllTransaction';

    try {
      final response = await http.get(
        Uri.parse('$host$path'),
        headers: {
          'Authorization': 'bearer $token',
        },
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _transactions.clear();
          _transactions
              .addAll(data.map((json) => Transaction.fromJson(json)).toList());
          _transactions.sort((a, b) => b.transactionDate
              .compareTo(a.transactionDate)); // Tarihe göre sırala
          _loading = false;
        });
      } else {
        print('Transaction error: ${response.statusCode}, ${response.body}');

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Üzgünüz'),
              content: const Text('Verileri alırken bir hata oluştu.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Tamam'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  void _showTransactionDetails(BuildContext context, Transaction transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
              side: BorderSide(
                color: transaction.transactionType == 'Income'
                    ? Colors.green
                    : Colors.red,
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
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lexend'),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Kategori: ${transaction.category}',
                  style: const TextStyle(fontFamily: 'Lexend'),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Tarih: ${_formatTransactionDate(transaction.transactionDate)}',
                  style: const TextStyle(fontFamily: 'Lexend'),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Miktar: ${transaction.amount}₺',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: transaction.transactionType == 'Income'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
                const SizedBox(height: 16.0),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      _deleteTransaction(transaction.transactionId);
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const Text(
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

  String _formatTransactionDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    if (date.isAtSameMomentAs(today)) {
      return 'Bugün';
    } else if (date.isAtSameMomentAs(yesterday)) {
      return 'Dün';
    } else {
      return DateFormat('dd.MM.yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              ..._transactions
                  .take(_showMore ? _transactions.length : 4)
                  .map((transaction) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: GestureDetector(
                    onTap: () => _showTransactionDetails(context, transaction),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          width: 3,
                          color: transaction.transactionType == 'Income'
                              ? Colors.green
                              : Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _formatTransactionDate(
                                      transaction.transactionDate),
                                  style: const TextStyle(
                                      color: Colors.grey, fontFamily: 'Lexend'),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  transaction.description,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lexend'),
                                ),
                              ],
                            ),
                            Text(
                              '${transaction.amount}₺',
                              style: TextStyle(
                                color: transaction.transactionType == 'Income'
                                    ? Colors.green
                                    : Colors.red,
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
              }),
              if (_transactions.length > 4)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showMore = !_showMore;
                    });
                  },
                  child: Text(
                    _showMore ? 'Daha Az Göster' : 'Daha Fazla Göster',
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Lexend',
                      color: Colors.grey,
                    ),
                  ),
                ),
            ],
          );
  }
}
