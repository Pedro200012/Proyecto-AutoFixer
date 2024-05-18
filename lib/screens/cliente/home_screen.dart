import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class ClienteHomeScreen extends StatelessWidget {
  const ClienteHomeScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        automaticallyImplyLeading: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ElevatedButton(
            onPressed: () {
              // Add your onPressed logic for button 1
              print('Cliente Button 1 pressed');
            },
            child: Text('Cliente Action 1'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Add your onPressed logic for button 2
              print('Cliente Button 2 pressed');
            },
            child: Text('Cliente Action 2'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Add your onPressed logic for button 3
              print('Cliente Button 3 pressed');
            },
            child: Text('Cliente Action 3'),
          ),
          // Add more buttons as needed
        ],
      ),
    );
  }
}
