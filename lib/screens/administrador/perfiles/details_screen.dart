import 'package:flutter/material.dart';
import 'package:aplicacion_taller/screens/administrador/perfiles_screen.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile: ${user.name}'),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Phone: ${user.phone}', style: TextStyle(fontSize: 18)),
            // Add more user details as needed
          ],
        ),
      ),
    );
  }
}
