import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social_media_o/app/pages/earned_screen/widgets/earned_header.dart';
import 'package:social_media_o/app/common/drawer/home_drawer.dart';
import '../../home_screen/controller/expense_controller.dart';
import '../widgets/earned_list_item.dart';

class EarnedScreen extends GetView {
  final ExpenseController expenseController = Get.find<ExpenseController>();
EarnedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earned Amount',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      drawer: HomeDrawer(context: context),
      body:  CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: StreamBuilder<QuerySnapshot>(
              stream: expenseController.getExpenses(),
              builder: (context, snapshot) {
                double earnedAmount = 0.0;
                if (snapshot.hasData) {
                  final docs = snapshot.data!.docs;

                  for (var doc in docs) {
                    final data = doc.data() as Map<String, dynamic>;
                    final amount = data['amount'] != null ?(data['amount'] as num).toDouble() : 0.0;
                    if (amount >= 0) {
                      earnedAmount += amount;
                    }
                  }
                }
                return EarnedHeader(earnedAmount: '\$${earnedAmount.toStringAsFixed(2)}');
              },

            ),
          ),
          _buildEarnedList(),
        ],
      ),
    );
  }
  Widget _buildEarnedList() {
    return StreamBuilder<QuerySnapshot>(
      stream: expenseController.getExpenses(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // Filter only positive (earned) expenses.
          final List<DocumentSnapshot> positiveDocs = snapshot.data!.docs.where((doc) {
            final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            final double amountValue = (data['amount'] ?? 0).toDouble();
            return amountValue >= 0;
          }).toList();

          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(milliseconds: 400 + index * 50),
                  builder: (context, opacity, child) {
                    return Opacity(opacity: opacity, child: child);
                  },
                  child: EarnedListItem(
                    index: index,
                    expense: positiveDocs[index],
                  ),
                );
              },
              childCount: positiveDocs.length,
            ),
          );
        } else if (snapshot.hasError) {
          return SliverFillRemaining(
            child: Center(
              child: Text(
                'Error loading data',
                style: TextStyle(color: Colors.red.shade300, fontSize: 16),
              ),
            ),
          );
        } else {
          return const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

}
