import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../../firebase/firestore/firestore.dart';

class ExpenseController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();
  var isLoading = false.obs;

  // Get current user's UID

  String get uid => FirebaseAuth.instance.currentUser?.uid ?? '';
  // Get current user's email
  String get email => FirebaseAuth.instance.currentUser?.email ?? '';
  // Get current user's name
  String get name => FirebaseAuth.instance.currentUser?.displayName ?? '';


  Future<void> addExpense(String name, double amount, String desc) async {
    if (uid.isEmpty) return;
    isLoading.value = true;
    await _firestoreService.addExpense(uid, name, amount, desc);
    isLoading.value = false;
  }

  Stream<QuerySnapshot<Object?>> getExpenses() {
    if (uid.isEmpty) return const Stream.empty();
    return _firestoreService.getExpenses(uid);
  }

  Future<void> deleteExpense(String expenseId) async {
    if (uid.isEmpty) return;
    await _firestoreService.deleteExpense(uid, expenseId);
  }

  Future<void> updateExpense(String expenseId, String name, double amount, String desc) async {
    if (uid.isEmpty) return;
    isLoading.value = true;
    await _firestoreService.updateExpense(uid, expenseId, name, amount, desc);
    isLoading.value = false;
  }
}
