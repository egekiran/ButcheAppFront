import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actionsIconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 81, 45, 168),
        title: Text(
          'İstatistikler',
          style: TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Bütçe Dağılım Grafiği',
            style: TextStyle(
              fontFamily: 'Lexend',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ]),
      ),
    );
  }
}
