import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../home_screen/widget/edit_delete.dart';
import '../../home_screen/widget/expense_details.dart';

class EarnedListItem extends StatelessWidget {
  final int index;
  final DocumentSnapshot expense;

  const EarnedListItem({
    super.key,
    required this.index,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data = expense.data() as Map<String, dynamic>;

    final String name = data['expenseName'] ?? 'No Name';
    final String date = data['createdAt'] != null
        ? DateFormat('yMMMd')
        .format((data['createdAt'] as Timestamp).toDate())
        : 'No Date';
    final double amountValue = (data['amount'] ?? 0).toDouble();
    final String amount = "\$${amountValue.toStringAsFixed(2)}";

    return Padding(
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
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            subtitle: Text(
              date,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  amount,
                  style: TextStyle(
                    color: Colors.green[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 8),
                EditDelete(
                  id: expense.id,
                  name: data['expenseName'],
                  description: data['description'],
                  amount: data['amount'],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
