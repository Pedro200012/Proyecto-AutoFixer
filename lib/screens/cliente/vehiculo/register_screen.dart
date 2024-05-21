import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class VehicleRegisterScreen extends StatelessWidget {
  static const String name = 'registro-vehiculo-screen';
  const VehicleRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro auto'),
      ),
      body: const SingleChildScrollView(
        child: Center(
          child: _RegistroAutoView(),
        ),
      ),
    );
  }
}

class _RegistroAutoView extends StatefulWidget {
  const _RegistroAutoView();

  @override
  _RegistroAutoViewState createState() => _RegistroAutoViewState();
}

class _RegistroAutoViewState extends State<_RegistroAutoView> {
  final TextEditingController _modeloController = TextEditingController();
  final TextEditingController _marcaController = TextEditingController();
  final TextEditingController _patenteController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

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
              onPressed: () {
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Auto registrado correctamente.'),
                    ),
                  );
                  // autos.add(Auto(
                  //     modelo: modelo,
                  //     marca: marca,
                  //     patente: patente,
                  //     year: int.tryParse(year)));

                  // Actualizar el estado para reconstruir la interfaz de usuario
                  setState(() {});

                  // Volver a la pantalla anterior
                  context.pop();
                }
              },
              child: const Text('Agregar auto'),
            ),
          ),
        ],
      ),
    );
  }
}
