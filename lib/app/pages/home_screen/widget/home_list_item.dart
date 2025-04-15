import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'edit_delete.dart';
import 'expense_details.dart';

class HomeListItem extends StatelessWidget {
  const HomeListItem({super.key, required this.index, required this.snapshot});

  final int index;
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    final expenseList = snapshot.data!.docs;
    final DocumentSnapshot expense = expenseList[index];
    final Map<String, dynamic> data = expense.data() as Map<String, dynamic>;

    final String name = data['expenseName'] ?? 'No Name';
    final String date =
        data['createdAt'] != null
            ? (data['createdAt'] as Timestamp).toDate().toString().split(' ')[0]
            : 'No Date';
    final double amountValue = data['amount'] != null ? (data['amount'] as num).toDouble() : 0.0;

    final String amount = "\$${amountValue.toStringAsFixed(2)}";

    return
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ExpenseDetails(
                name: name,
                date: date,
                data: data,
                amount: amount,
                amountValue: amountValue,
                context: context,
              );
            },
          );
        },
        child:
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            leading: CircleAvatar(
              backgroundColor: Colors.indigo.shade100,
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                  color: Colors.indigo,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            title: Text(
              name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            subtitle: Text(date, style: TextStyle(color: Colors.grey.shade600)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  amount,
                  style: TextStyle(
                    color:
                        amountValue < 0
                            ? Colors.red.shade400
                            : Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
                EditDelete(
                  id: expense.id,
                  name: data['expenseName'],
                  description: data['description'],
                  amount: data['amount'] != null ? (data['amount'] as num).toDouble() : 0.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
