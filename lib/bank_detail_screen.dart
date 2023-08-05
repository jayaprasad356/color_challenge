import 'package:flutter/material.dart';

class BankDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Details'),
      ),
      body: BankDetailsForm(),
    );
  }
}

class BankDetailsForm extends StatefulWidget {
  @override
  _BankDetailsFormState createState() => _BankDetailsFormState();
}

class _BankDetailsFormState extends State<BankDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _accountNumberController = TextEditingController();
  TextEditingController _ifscCodeController = TextEditingController();
  TextEditingController _branchNameController = TextEditingController(); // New field for branch name

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _bankNameController,
              decoration: InputDecoration(labelText: 'Bank Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _accountNumberController,
              decoration: InputDecoration(labelText: 'Account Number'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _ifscCodeController,
              decoration: InputDecoration(labelText: 'IFSC Code'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _branchNameController,
              decoration: InputDecoration(labelText: 'Branch Name'), // New field for branch name
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Save the bank details or perform any other action here
                  String bankName = _bankNameController.text;
                  String accountNumber = _accountNumberController.text;
                  String ifscCode = _ifscCodeController.text;
                  String branchName = _branchNameController.text; // New field for branch name

                  // You can perform any operation with the data here, e.g., save to database, send to server, etc.

                  // Show a success message or navigate back to the previous screen.
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Bank details saved successfully!')),
                  );
                }
              },
              child: Text('Save Bank Details'),
            ),
          ],
        ),
      ),
    );
  }
}
