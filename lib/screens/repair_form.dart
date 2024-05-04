import 'package:flutter/material.dart';

// ignore: use_key_in_widget_constructors
class RepairRequestForm extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _RepairRequestFormState createState() => _RepairRequestFormState();
}

class _RepairRequestFormState extends State<RepairRequestForm> {
  final TextEditingController _vehicleModelController = TextEditingController();
  final TextEditingController _issueDescriptionController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  String _selectedType = 'Reparación general'; // Valor predeterminado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitud de Reparación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedType,
              onChanged: (newValue) {
                setState(() {
                  _selectedType = newValue!;
                });
              },
              items: <String>['Reparación general', 'Cambio de aceite', 'Reemplazo de neumáticos', 'Otros']
                .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                })
                .toList(),
              decoration: const InputDecoration(
                labelText: 'Tipo de Reparación',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _vehicleModelController,
              decoration: const InputDecoration(labelText: 'Modelo del Vehículo'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _issueDescriptionController,
              decoration: const InputDecoration(labelText: 'Descripción del Problema'),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _contactNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Número de Contacto'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes enviar los datos del formulario
                _submitForm();
              },
              child: const Text('Enviar Solicitud'),
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    // Aquí puedes procesar los datos del formulario, por ejemplo, enviarlos a un servidor o almacenarlos localmente.
    String selectedType = _selectedType;
    String vehicleModel = _vehicleModelController.text;
    String issueDescription = _issueDescriptionController.text;
    String contactNumber = _contactNumberController.text;

    // Puedes imprimir los datos para verificar que se hayan recogido correctamente
    print('Tipo de Reparación: $selectedType');
    print('Modelo del Vehículo: $vehicleModel');
    print('Descripción del Problema: $issueDescription');
    print('Número de Contacto: $contactNumber');

    // Limpia los campos después de enviar la solicitud
    _vehicleModelController.clear();
    _issueDescriptionController.clear();
    _contactNumberController.clear();

    // Puedes mostrar un mensaje de éxito o navegar a otra pantalla aquí
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
       content: Text('Solicitud enviada con éxito'),
    ));
  }

  @override
  void dispose() {
    // Limpia los controladores al desechar el widget para evitar memory leaks
    _vehicleModelController.dispose();
    _issueDescriptionController.dispose();
    _contactNumberController.dispose();
    super.dispose();
  }
}