import 'package:flutter/material.dart';
import 'package:aplicacion_taller/screens/administrador/perfiles/details_screen.dart';
import 'package:aplicacion_taller/screens/administrador/perfiles/edit_screen.dart';

class Contact {
  final String name;
  final String phone;

  Contact({required this.name, required this.phone});
}

class PerfilesScreen extends StatelessWidget {
  const PerfilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Contact> contacts = [
      Contact(name: 'John Doe', phone: '123-456-7890'),
      Contact(name: 'Jane Smith', phone: '987-654-3210'),
      Contact(name: 'Robert Johnson', phone: '456-789-1230'),
      Contact(name: 'Michael Brown', phone: '789-123-4560'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfiles'),
        automaticallyImplyLeading: true,
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              title: Text(contact.name),
              subtitle: Text(contact.phone),
              onTap: () {
                // Navigate to profile page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(contact: contact),
                  ),
                );
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Navigate to edit profile page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(contact: contact),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Show confirmation dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirm Deletion'),
                            content: Text('Are you sure you want to delete ${contact.name}?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Implement delete functionality
                                  print('Deleted ${contact.name}');
                                  Navigator.of(context).pop();
                                },
                                child: Text('Delete'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
