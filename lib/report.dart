import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
      ),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your name',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter your phone number',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter the phone number of emergency contact',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                // if (_formKey.currentState.validate()) {
                //   // If the form is valid, display a snackbar. In the real world,
                //   // you'd often call a server or save the information in a database.
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('Processing Data')),
                //   );
                // }
              },
              child: const Text('Submit'),
            ),
          ],
        )
      )
    );
  }
}
