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
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: const Column(
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

  const BudgetItem({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
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
                LinearProgressIndicator(
                  value: 0.6,
                  color: color,
                  backgroundColor: color.withOpacity(0.2),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
