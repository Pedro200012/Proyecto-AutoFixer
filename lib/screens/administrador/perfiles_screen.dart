import 'package:flutter/material.dart';

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
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Implement edit functionality
                      print('Edit ${contact.name}');
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Implement delete functionality
                      print('Delete ${contact.name}');
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
