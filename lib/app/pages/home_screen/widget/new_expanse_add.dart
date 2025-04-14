import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/expense_controller.dart';

class NewExpanseAdd extends StatelessWidget {
  NewExpanseAdd({super.key});
  final expenseController = Get.find<ExpenseController>();

  @override
  Widget build(BuildContext context) {
    // Controllers for the input fields.
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(
        context,
        nameController,
        descriptionController,
        amountController,
      ),
    );
  }

  Widget _buildDialogContent(
      BuildContext context,
      TextEditingController nameController,
      TextEditingController descriptionController,
      TextEditingController amountController,
      ) {
    return Container(
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
            // Title Header
            Text(
              "New Expense",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade700,
              ),
            ),
            const SizedBox(height: 20),
            // Expense Name TextField
            _buildTextField(
              controller: nameController,
              label: "Expense Name",
            ),
            const SizedBox(height: 16),
            // Description TextField
            _buildTextField(
              controller: descriptionController,
              label: "Description",
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            // Amount TextField
            _buildTextField(
              controller: amountController,
              label: "Amount",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            // Save Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Colors.indigo,
              ),
              onPressed: () {
                String name = nameController.text;
                String description = descriptionController.text;
                double amount = double.tryParse(amountController.text) ?? 0.0;
                if (name.isNotEmpty &&
                    description.isNotEmpty &&
                    amount != 0) {
                  expenseController.addExpense(name, amount, description);
                  Get.snackbar(
                    'Success',
                    'Expense added successfully',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                } else {
                  Get.snackbar(
                    'Error',
                    'Please fill all fields correctly',
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
                // Close the dialog after saving.
                Navigator.of(context).pop();
              },
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable method for building styled text fields.
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
        contentPadding:
        const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
