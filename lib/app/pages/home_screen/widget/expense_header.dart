
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../controller/expense_controller.dart';

class ExpenseHeader extends StatelessWidget {
  const ExpenseHeader({
    super.key,
    required this.expenseController,
  });

  final ExpenseController expenseController;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: expenseController.getExpenses(),
      builder: (context, snapshot) {
        double totalAmount = 0.0;
        double earnedAmount = 0.0;
        double spentAmount = 0.0;

        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;

          for (var doc in docs) {
            final data = doc.data() as Map<String, dynamic>;
            final amount = data['amount'] != null ? data['amount'] as double : 0.0;

            totalAmount += amount;
            if (amount >= 0) {
              earnedAmount += amount;
            } else {
              spentAmount += amount.abs();
            }
          }
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              Container(
                height: 110,
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Lottie.asset(
                      'assets/animations/Animation - 1744561224302.json',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Total Amount',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "\$${totalAmount.toStringAsFixed(2)}",
                          style: const TextStyle(
                            color: Colors.indigo,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      leading: const Icon(Icons.arrow_upward, color: Colors.green),
                      title: const Text('Earned', style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(
                        "\$${earnedAmount.toStringAsFixed(2)}",
                        style: TextStyle(color: Colors.green.shade700),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ListTile(
                      tileColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: Colors.grey.shade300),
                      ),
                      leading: const Icon(Icons.arrow_downward, color: Colors.red),
                      title: const Text('Spent', style: TextStyle(fontWeight: FontWeight.w600)),
                      subtitle: Text(
                        "\$${spentAmount.toStringAsFixed(2)}",
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}