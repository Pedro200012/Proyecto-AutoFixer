import 'package:flutter/material.dart';
import 'package:aplicacion_taller/entities/user.dart';
import 'package:aplicacion_taller/entities/vehicle.dart'; // Import the Vehicle class
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen({super.key, required this.user});

  Future<List<Vehicle>> _fetchUserVehicles() async {
    // Fetch vehicles from Firestore where userID matches the user's id
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('vehiculos')
        .where('userID', isEqualTo: user.id)
        .get();

    return querySnapshot.docs.map((doc) => Vehicle.fromFirestore(doc)).toList();
  }

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
            Text('Contact', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text('Name: ${user.name}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Phone: ${user.phone}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text('Vehicles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: FutureBuilder<List<Vehicle>>(
                future: _fetchUserVehicles(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error fetching vehicles'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No vehicles found'));
                  } else {
                    // Display the list of vehicles
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var vehicle = snapshot.data![index];
                        return ListTile(
                          title: Text('${vehicle.brand} ${vehicle.model} (${vehicle.year ?? 'N/A'})'),
                          subtitle: Text('License Plate: ${vehicle.licensePlate}'),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
