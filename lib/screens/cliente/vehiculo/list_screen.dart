import 'package:aplicacion_taller/entities/vehicle.dart';
import 'package:aplicacion_taller/screens/cliente/vehiculo/details_screen.dart';
import 'package:aplicacion_taller/screens/cliente/vehiculo/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VehicleListScreen extends StatefulWidget {
  static const String name = 'home-screen';

  const VehicleListScreen({super.key});

  @override
  _VehicleListScreenState createState() => _VehicleListScreenState();
}

class _VehicleListScreenState extends State<VehicleListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehiculos'),
      ),
      body: ListView.builder(
        itemCount: vehicles.length,
        itemBuilder: (context, index) {
          final autoAux = vehicles[index];
          return _buildAutoCard(autoAux);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const VehicleRegisterScreen(
                      key: null,
                    )),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildAutoCard(Vehicle vehiculo) {
    return Card(
      child: ListTile(
        title: Text(vehiculo.brand),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          context.push('/cliente/vehiculo/details', extra: vehiculo);
        },
      ),
    );
  }
}
