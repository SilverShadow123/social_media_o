import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/expense_controller.dart';

class EditDelete extends StatelessWidget {
  final String id;
  final String name;
  final String description;
  final double amount;

  const EditDelete({
    super.key,
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    final expenseController = Get.find<ExpenseController>();

    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert, color: Colors.black54),
      onSelected: (value) {
        if (value == 'Edit') {
          final nameController = TextEditingController(text: name);
          final descController = TextEditingController(text: description);
          final amountController = TextEditingController(text: amount.toString());

          showDialog(
            context: context,
            builder: (context) => Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                height: 420,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Edit Expense",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(controller: nameController, label: "Expense Name"),
                      const SizedBox(height: 16),
                      _buildTextField(controller: descController, label: "Description", maxLines: 2),
                      const SizedBox(height: 16),
                      _buildTextField(controller: amountController, label: "Amount", keyboardType: TextInputType.number),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.indigo,
                        ),
                        onPressed: () {
                          String newName = nameController.text;
                          String newDesc = descController.text;
                          double newAmount = double.tryParse(amountController.text) ?? 0.0;

                          if (newName.isNotEmpty && newDesc.isNotEmpty && newAmount != 0) {
                            expenseController.updateExpense(id, newName, newAmount, newDesc);
                            Get.snackbar('Success', 'Expense updated successfully',
                                backgroundColor: Colors.green, colorText: Colors.white);
                            Navigator.of(context).pop();
                          } else {
                            Get.snackbar('Error', 'Please fill all fields correctly',
                                backgroundColor: Colors.red, colorText: Colors.white);
                          }
                        },
                        child: const Text('Save', style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        else if (value == 'Delete') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Delete Expense'),
              content: const Text('Are you sure you want to delete this expense?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    expenseController.deleteExpense(id);
                    Navigator.of(context).pop();
                    Get.snackbar(
                      'Deleted',
                      'Expense has been deleted',
                      backgroundColor: Colors.redAccent,
                      colorText: Colors.white,
                    );
                  },
                  child: const Text('Delete', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );
        }
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'Edit', child: Text('Edit')),
        PopupMenuItem(value: 'Delete', child: Text('Delete')),
      ],
    );
  }

  /// Reusable styled TextField
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.indigo.shade600),
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
