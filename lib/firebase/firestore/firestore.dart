import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save user info
  Future<void> addUser(String uid, String name, String email) async {
    try {
      await _db.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  // Reference to the user's expenses subcollection
  CollectionReference getUserExpensesCollection(String uid) {
    return _db.collection('users').doc(uid).collection('expenses');
  }

  Future<void> addExpense(String uid, String expenseName, double amount, String description) async {
    try {
      await getUserExpensesCollection(uid).add({
        'expenseName': expenseName,
        'amount': amount,
        'description': description,
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error adding expense: $e');
    }
  }

  Stream<QuerySnapshot> getExpenses(String uid) {
    return getUserExpensesCollection(uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  Future<void> deleteExpense(String uid, String expenseId) async {
    try {
      await getUserExpensesCollection(uid).doc(expenseId).delete();
    } catch (e) {
      print('Error deleting expense: $e');
    }
  }

  Future<void> updateExpense(String uid, String expenseId, String name, double amount, String description) async {
    try {
      await getUserExpensesCollection(uid).doc(expenseId).update({
        'expenseName': name,
        'amount': amount,
        'description': description,
      });
    } catch (e) {
      print('Error updating expense: $e');
    }
  }
}
