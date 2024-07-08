import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 80,
        elevation: 0,
        destinations: const [
          NavigationDestination(
            icon: Icon(Iconsax.chart_3),
            label: 'Statistics',
          ),
          NavigationDestination(icon: Icon(Iconsax.home), label: 'Ana Sayfa'),
          NavigationDestination(
              icon: Icon(Iconsax.profile_circle), label: 'Profil'),
        ],
      ),
      body: Container(),
    );
  }
}
