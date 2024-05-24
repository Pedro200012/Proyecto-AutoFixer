import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplicacion_taller/entities/user.dart';
import 'package:aplicacion_taller/entities/vehicle.dart';

class ProfileScreen extends StatefulWidget {
  final User user;

  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  Future<List<Vehicle>> _fetchUserVehicles() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('vehiculos')
        .where('userID', isEqualTo: user.id)
        .get();

    return querySnapshot.docs.map((doc) => Vehicle.fromFirestore(doc)).toList();
  }

  Future<void> _deleteVehicle(String vehicleId) async {
    await FirebaseFirestore.instance.collection('vehiculos').doc(vehicleId).delete();
  }

  void _editUserInfo(BuildContext context) {
    final TextEditingController nameController = TextEditingController(text: user.name);
    final TextEditingController phoneController = TextEditingController(text: user.phone);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit User Information'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('users')
                    .doc(user.id)
                    .update({
                  'name': nameController.text,
                  'phone': phoneController.text,
                });

                setState(() {
                  user = User(
                    id: user.id,
                    name: nameController.text,
                    phone: phoneController.text,
                  );
                });

                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _editVehicle(BuildContext context, Vehicle vehicle) {
    final TextEditingController modelController = TextEditingController(text: vehicle.model);
    final TextEditingController brandController = TextEditingController(text: vehicle.brand);
    final TextEditingController licensePlateController = TextEditingController(text: vehicle.licensePlate);
    final TextEditingController yearController = TextEditingController(text: vehicle.year ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Vehicle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: modelController,
                decoration: InputDecoration(labelText: 'Model'),
              ),
              TextField(
                controller: brandController,
                decoration: InputDecoration(labelText: 'Brand'),
              ),
              TextField(
                controller: licensePlateController,
                decoration: InputDecoration(labelText: 'License Plate'),
              ),
              TextField(
                controller: yearController,
                decoration: InputDecoration(labelText: 'Year'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection('vehiculos')
                      .doc(vehicle.id) // Use vehicle.id instead of vehicle.licensePlate
                      .update({
                    'model': modelController.text,
                    'brand': brandController.text,
                    'licensePlate': licensePlateController.text,
                    'year': yearController.text.isEmpty ? null : yearController.text,
                  });

                  setState(() {});
                  Navigator.of(context).pop();
                } catch (e) {
                  print('Error updating vehicle: $e');
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
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
            Card(
              elevation: 4,
              child: ListTile(
                title: Text('Name: ${user.name}'),
                subtitle: Text('Phone: ${user.phone}'),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editUserInfo(context),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Vehicles:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var vehicle = snapshot.data![index];
                        return Card(
                          elevation: 4,
                          child: ListTile(
                            title: Text('${vehicle.brand} ${vehicle.model} (${vehicle.year ?? 'N/A'})'),
                            subtitle: Text('License Plate: ${vehicle.licensePlate}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit),
                                  onPressed: () {
                                    _editVehicle(context, vehicle);
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () async {
                                    bool? confirmDelete = await showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text('Delete Vehicle'),
                                        content: Text('Are you sure you want to delete this vehicle?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(false),
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(true),
                                            child: Text('Delete'),
                                          ),
                                        ],
                                      ),
                                    );
                                    if (confirmDelete == true) {
                                      await _deleteVehicle(vehicle.id); // Use vehicle.id instead of vehicle.licensePlate
                                      setState(() {});
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
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
