import 'package:flutter/material.dart';
import 'package:aplicacion_taller/screens/administrador/perfiles_screen.dart';

class EditProfileScreen extends StatelessWidget {
  final Contact contact;

  const EditProfileScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile: ${contact.name}'),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              controller: TextEditingController(text: contact.name),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Phone'),
              controller: TextEditingController(text: contact.phone),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement save functionality
                print('Save changes for ${contact.name}');
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
