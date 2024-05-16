import 'package:flutter/material.dart';
import 'package:aplicacion_taller/screens/administrador/perfiles_screen.dart';

class ProfileScreen extends StatelessWidget {
  final Contact contact;

  const ProfileScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile: ${contact.name}'),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${contact.name}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Phone: ${contact.phone}', style: TextStyle(fontSize: 18)),
            // Add more contact details as needed
          ],
        ),
      ),
    );
  }
}
