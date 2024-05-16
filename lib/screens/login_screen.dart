import 'package:flutter/material.dart';
import 'package:aplicacion_taller/screens/administrador/home_screen.dart';
import 'package:aplicacion_taller/screens/cliente/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdministradorHomeScreen(),
                  ),
                );
              },
              child: Text('Administrador'),
            ),
            SizedBox(height: 20), // Add space between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ClienteHomeScreen(),
                  ),
                );
              },
              child: Text('Cliente'),
            ),
          ],
        ),
      ),
    );
  }
}
