import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:animated_digit/animated_digit.dart';

class HeaderSection extends StatefulWidget {
  const HeaderSection({super.key});

  @override
  State<HeaderSection> createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  final storage = const FlutterSecureStorage();
  String UserName = 'User';
  int Income = 0;
  int Expense = 0;
  int CurrentBalance = 0;
  @override
  void initState() {
    super.initState();
    _getCurrentBalance();
  }

  Future<void> _getCurrentBalance() async {
    const host = 'https://butchebackendapi.azurewebsites.net/';
    const path = 'api/Transactions/GetCurrentBalance';

    try {
      String? token = await storage.read(key: 'accessToken');

      if (token != null) {
        final response = await http.get(
          Uri.parse('$host$path'),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': 'bearer $token',
          },
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          setState(() {
            UserName = data['nameSurname'] ?? 'default';
            Income = data['income'] ?? 0;
            Expense = data['expense'] ?? 0;
            CurrentBalance = data['currentBalance'] ?? 0;
          });
        } else {
          print('Failed to get current balance: ${response.statusCode}');
          print(token);
        }
      } else {
        print('No access token found');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 81, 45, 168),
            Color.fromARGB(255, 103, 58, 183),
          ],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(8, 26, 0, 0),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Merhaba, ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Text(
                      UserName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                      ),
                    ),
                  ],
                ),
                AnimatedDigitWidget(
                  value: CurrentBalance,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lexend',
                  ),
                  enableSeparator: true,
                  separateSymbol: ".",
                  separateLength: 3,
                  decimalSeparator: ",",
                  prefix: "₺",
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(0, 20, 16, 0),
            alignment: Alignment.centerRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 130,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: AnimatedDigitWidget(
                      value: Income,
                      textStyle: const TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                      ),
                      enableSeparator: true,
                      separateSymbol: ".",
                      separateLength: 3,
                      decimalSeparator: ",",
                      prefix: "₺",
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: 130,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: AnimatedDigitWidget(
                      value: Expense,
                      textStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lexend',
                      ),
                      enableSeparator: true,
                      separateSymbol: ".",
                      separateLength: 3,
                      decimalSeparator: ",",
                      prefix: "₺",
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
