import 'package:flutter/material.dart';

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
        children: [
          BudgetItem(
            icon: Icons.fastfood,
            label: 'Yeme & İçme',
            color: Colors.orange,
          ),
          BudgetItem(
            icon: Icons.checkroom,
            label: 'Giyim',
            color: Colors.purple,
          ),
          BudgetItem(
            icon: Icons.movie,
            label: 'Eğlence',
            color: Colors.blue,
          ),
          BudgetItem(
            icon: Icons.credit_card,
            label: 'Düzenli Ödemeler',
            color: Colors.green,
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

  BudgetItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 28, color: color),
          Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: 0.6,
              color: color,
              backgroundColor: color.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
