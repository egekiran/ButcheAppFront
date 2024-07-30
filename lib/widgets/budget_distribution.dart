import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';

class BudgetDistributionSection extends StatefulWidget {
  const BudgetDistributionSection({super.key});

  @override
  State<BudgetDistributionSection> createState() =>
      _BudgetDistributionSectionState();
}

class _BudgetDistributionSectionState extends State<BudgetDistributionSection> {
  @override
  Widget build(BuildContext context) {
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
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          BudgetItem(
            icon: Icons.fastfood,
            label: 'Yeme & İçme',
            color: Colors.orange,
            value: 43,
          ),
          BudgetItem(
            icon: Icons.checkroom,
            label: 'Giyim',
            color: Colors.purple,
            value: 15,
          ),
          BudgetItem(
            icon: Icons.movie,
            label: 'Eğlence',
            color: Colors.blue,
            value: 30,
          ),
          BudgetItem(
            icon: Icons.credit_card,
            label: 'Düzenli Ödemeler',
            color: Colors.green,
            value: 12,
          ),
        ],
      ),
    );
  }
}

class BudgetItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final double value;

  const BudgetItem({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        children: [
          Icon(icon, size: 34, color: color),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                FAProgressBar(
                  currentValue: value,
                  displayText: null,
                  progressColor: color,
                  backgroundColor: color.withOpacity(0.2),
                  direction: Axis.horizontal,
                  size: 10,
                  animatedDuration: const Duration(milliseconds: 600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
