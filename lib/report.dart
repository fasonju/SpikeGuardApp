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

  const EmergencyInformationForm(this.sharedPreferences, {super.key});

  @override
  State<EmergencyInformationForm> createState() => _EmergencyInformationFormState();
}

class _EmergencyInformationFormState extends State<EmergencyInformationForm> {

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController emergencyContactPhoneController;
  late TextEditingController lastNameController;
  late TextEditingController cityController;
  late TextEditingController countryController;


  @override
  Widget build(BuildContext context) {
    nameController = TextEditingController(text: getCachedValue("name"));
    lastNameController = TextEditingController(text: getCachedValue("last_name"));
    phoneController = TextEditingController(text: getCachedValue("phone"));
    cityController = TextEditingController(text: getCachedValue("city"));
    countryController = TextEditingController(text: getCachedValue("country"));
    addressController = TextEditingController(text: getCachedValue("address"));
    emergencyContactPhoneController = TextEditingController(text: getCachedValue("emergency_contact_phone"));

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'First name',
                ),
                controller: nameController,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Last name',
                ),
                controller: lastNameController,
              ),
            ),
          ],
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Phone number',
          ),
          controller: phoneController,
        ),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Country',
                ),
                controller: countryController,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'City',
                ),
                controller: cityController,
              ),
            ),
          ],
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
    if (nameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        cityController.text.isEmpty ||
        countryController.text.isEmpty ||
        addressController.text.isEmpty ||
        emergencyContactPhoneController.text.isEmpty) {
      showDialog(context: context, builder: (BuildContext context) {
        return  AlertDialog(
          title: const Text('Error'),
          content: const Text('All fields are required'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      });
      return;
    }

    saveValue("name", nameController.text);
    saveValue("last_name", lastNameController.text);
    saveValue("city", cityController.text);
    saveValue("country", countryController.text);
    saveValue("phone", phoneController.text);
    saveValue("address", addressController.text);
    saveValue("emergency_contact_phone", emergencyContactPhoneController.text);
  }

  saveValue(String key, String value) {
    widget.sharedPreferences.setString(key, value);
  }
}
