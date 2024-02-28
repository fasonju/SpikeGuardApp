import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmergencyInformationPage extends StatelessWidget {
  const EmergencyInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emergency Information'),
      ),
      body: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            return EmergencyInformationForm(snapshot.data!);
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}


class EmergencyInformationForm extends StatefulWidget {
  final SharedPreferences sharedPreferences;

  EmergencyInformationForm(this.sharedPreferences, {super.key});

  @override
  State<EmergencyInformationForm> createState() => _EmergencyInformationFormState();
}

class _EmergencyInformationFormState extends State<EmergencyInformationForm> {

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController emergencyContactPhoneController;

  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: getCachedValue("name"));
    phoneController = TextEditingController(text: getCachedValue("phone"));
    addressController = TextEditingController(text: getCachedValue("address"));
    emergencyContactPhoneController = TextEditingController(text: getCachedValue("emergency_contact_phone"));

    return Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Name',
          ),
          controller: nameController,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Phone number',
          ),
          controller: phoneController,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Address',
          ),
          controller: addressController,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Emergency contact phone',
          ),
          controller: emergencyContactPhoneController,
        ),
        ElevatedButton(
          onPressed: () {
            cacheFormValues();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }

  getCachedValue(String key) {
    try {
      return widget.sharedPreferences.getString(key);
    } catch (e) {
      return null;
    }
  }

  cacheFormValues() {
    saveValue("name", nameController.text);
    saveValue("phone", phoneController.text);
    saveValue("address", addressController.text);
    saveValue("emergency_contact_phone", emergencyContactPhoneController.text);
  }

  saveValue(String key, String value) {
    widget.sharedPreferences.setString(key, value);
  }
}
