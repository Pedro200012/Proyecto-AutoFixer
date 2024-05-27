import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplicacion_taller/entities/vehicle.dart';

class VehicleEditScreen extends StatelessWidget {
  static const String name = 'editar-vehiculo-screen';
  final Vehicle vehicle;

  const VehicleEditScreen({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar vehiculo'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: _RegistroAutoView(vehicle: vehicle),
        ),
      ),
    );
  }
}

class _RegistroAutoView extends StatefulWidget {
  final Vehicle vehicle;

  const _RegistroAutoView({required this.vehicle});

  @override
  _RegistroAutoViewState createState() => _RegistroAutoViewState();
}

class _RegistroAutoViewState extends State<_RegistroAutoView> {
  late TextEditingController _modeloController;
  late TextEditingController _marcaController;
  late TextEditingController _patenteController;
  late TextEditingController _yearController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  //obtener los datos actuales del vehiculo
  void initState() {
    super.initState();
    _modeloController = TextEditingController(text: widget.vehicle.model);
    _marcaController = TextEditingController(text: widget.vehicle.brand);
    _patenteController =
        TextEditingController(text: widget.vehicle.licensePlate);
    _yearController = TextEditingController(text: widget.vehicle.year);
  }

  @override
  void dispose() {
    _modeloController.dispose();
    _marcaController.dispose();
    _patenteController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _marcaController,
              decoration: const InputDecoration(
                hintText: 'Marca',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _modeloController,
              decoration: const InputDecoration(
                hintText: 'Modelo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _patenteController,
              decoration: const InputDecoration(
                hintText: 'Patente',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _yearController,
              decoration: const InputDecoration(
                hintText: 'Año',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                String modelo = _modeloController.text;
                String marca = _marcaController.text;
                String patente = _patenteController.text;
                String year = _yearController.text;

                // Validar campos (puedes agregar más validaciones según tus necesidades)
                if (modelo.isEmpty ||
                    marca.isEmpty ||
                    patente.isEmpty ||
                    year.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Por favor, complete todos los campos.'),
                    ),
                  );
                } else {
                  // Actualizar el documento en Firestore
                  await _firestore
                      .collection('vehiculos')
                      .doc(widget.vehicle.id)
                      .update({
                    'model': modelo,
                    'brand': marca,
                    'licensePlate': patente,
                    'year': year,
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Auto editado correctamente.'),
                    ),
                  );

                  // Volver a la pantalla anterior
                  context.pop();
                }
              },
              child: const Text('Editar vehiculo'),
            ),
          ),
        ],
      ),
    );
  }
}
