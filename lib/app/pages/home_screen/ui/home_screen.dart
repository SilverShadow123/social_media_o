import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../controller/expense_controller.dart';
import '../widget/expense_header.dart';
import '../../../common/drawer/home_drawer.dart';
import '../widget/home_list_item.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  final HomeController homeController = Get.find<HomeController>();
  final ExpenseController expenseController = Get.find<ExpenseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: HomeDrawer(context: context),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 32, right: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {
                controller.onOpeningFloatingActionButton();
              },
              backgroundColor: Colors.indigo,
              child: const Icon(Icons.add, color: Colors.white, size: 28),
              heroTag: 'add', // Important when using multiple FABs
            ),
            const SizedBox(height: 16), // Just enough spacing to look elegant
          ],
        ),
      ),

      appBar: AppBar(
        title: const Text(
          'Expensify',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () {
              homeController.logout();
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ExpenseHeader(expenseController: expenseController),
          ),
          _buildExpenseList(),
        ],
      ),
    );
  }


  // Expense list widget
  Widget _buildExpenseList() {
    return StreamBuilder<QuerySnapshot>(
      stream: expenseController.getExpenses(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 400 + index * 50),
                builder: (context, opacity, child) {
                  return Opacity(opacity: opacity, child: child);
                },
                child: HomeListItem(index: index, snapshot: snapshot),
              );
            }, childCount: docs.length),
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
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}
