import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../firebase/firestore/firestore.dart';
import '../model/graph_model.dart';
class GraphController extends GetxController {
  final FirestoreService firestoreService = FirestoreService();
  // Reactive list of expenses
  var expenses = <Expense>[].obs;

  @override
  void onInit() {
    super.onInit();
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      firestoreService.getExpenses(uid).listen((snapshot) {
        // Convert each document to an Expense model
        final List<Expense> loadedExpenses = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Expense(
            amount: (data['amount'] as num).toDouble(),
            createdAt: (data['createdAt'] as Timestamp).toDate(),
          );
        }).toList();

        expenses.value = loadedExpenses;
      });
    }
  }
}
