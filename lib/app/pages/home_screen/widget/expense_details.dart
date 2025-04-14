
import 'package:flutter/material.dart';

class ExpenseDetails extends StatelessWidget {
  const ExpenseDetails({
    super.key,
    required this.name,
    required this.date,
    required this.data,
    required this.amount,
    required this.amountValue,
    required this.context,
  });

  final String name;
  final String date;
  final Map<String, dynamic> data;
  final String amount;
  final double amountValue;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Expense Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              "Name: $name",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            Text(
              "Date: $date",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            Text(
              "Description: ${data['description'] ?? 'No Description'}",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),

            Text(
              "Amount: $amount",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: amountValue < 0 ? Colors.red : Colors.green,
              ),
            ),
            const SizedBox(height: 20),

            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Close",
                  style: TextStyle(
                    color: Colors.indigo,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}