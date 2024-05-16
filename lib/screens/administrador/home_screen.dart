import 'package:flutter/material.dart';
import 'package:aplicacion_taller/screens/administrador/perfiles_screen.dart';

class AdministradorHomeScreen extends StatelessWidget {
  const AdministradorHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Administrador Home'),
        automaticallyImplyLeading: true, // This shows the back arrow
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PerfilesScreen(),
                ),
              );
            },
            child: Text('Perfiles'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Add your onPressed logic for button 2
              print('Administrador Button 2 pressed');
            },
            child: Text('Admin Action 2'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              // Add your onPressed logic for button 3
              print('Administrador Button 3 pressed');
            },
            child: Text('Admin Action 3'),
          ),
          // Add more buttons as needed
        ],
      ),
    );
  }
}
