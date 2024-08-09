import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/butcheUILogo.svg',
              height: 80,
            ),
            SizedBox(height: 20),
            Text(
              'butche',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            Text(
              'Daily Budget Planning App',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 40),
            Text(
              'v0.1.4',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              '(Beta)',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset(
                    'assets/NeuraTechTeamLogo.svg',
                    height: 60,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
