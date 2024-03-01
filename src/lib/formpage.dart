import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key, required this.title});
final String title;
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>(); // Key to uniquely identify the form

  // Form fields' controllers
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool _isButtonEnabled = false; // Initially button is disabled

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Validation Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Associate the key with the form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (_) => _validateForm(), // Validate the form on text change
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  } else if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onChanged: (_) => _validateForm(), // Validate the form on text change
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _isButtonEnabled ? _submitForm : null, // Disable the button initially
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to validate the form
  void _validateForm() {
    setState(() {
      _isButtonEnabled = _formKey.currentState?.validate() ?? false; // Update the button state based on form validation
    });
  }

  // Method to handle form submission
  void _submitForm() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Form is valid. Submitting data...'),
    ));
    // Perform submission or other actions here
  }
}