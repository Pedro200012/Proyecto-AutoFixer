import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

import 'package:aplicacion_taller/entities/user.dart';

class PerfilesScreen extends StatelessWidget {
  const PerfilesScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

    return Scaffold(
      appBar: AppBar(
        title: Text('Perfiles'),
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder(
        stream: usersRef.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print("Error: ${snapshot.error}");
            return Center(child: Text('Something went wrong: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs.map((doc) => User.fromFirestore(doc)).toList();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.phone),
                  onTap: () {
                    // Navigate to profile page using go_router
                    context.push('/administrador/perfiles/profile', extra: user);
                  },
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Show confirmation dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Confirm Deletion'),
                            content: Text('Are you sure you want to delete ${user.name}?'),
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
                                  usersRef.doc(user.id).delete();
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
