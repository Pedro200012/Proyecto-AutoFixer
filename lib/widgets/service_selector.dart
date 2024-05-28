import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplicacion_taller/entities/service.dart';

class ServiceSelector extends StatefulWidget {
  final ValueChanged<Set<Service>> onServicesSelected;

  const ServiceSelector({super.key, required this.onServicesSelected});

  @override
  _ServiceSelectorState createState() => _ServiceSelectorState();
}

class _ServiceSelectorState extends State<ServiceSelector> {
  late Future<List<Service>> _servicesFuture;
  final Set<Service> _selectedServices = {};

  @override
  void initState() {
    super.initState();
    _servicesFuture = _fetchServices();
  }

  Future<List<Service>> _fetchServices() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('services')
        .get();
    return snapshot.docs.map((doc) => Service.fromFirestore(doc)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Service>>(
      future: _servicesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error al cargar los servicios'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No hay servicios disponibles'));
        } else {
          return ExpansionTile(
            title: const Text(
              'Seleccionar servicios',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            initiallyExpanded: true,
            children: snapshot.data!.map((service) {
              return CheckboxListTile(
                title: Row(
                  children: [
                    Text(service.name),
                    const Spacer(),
                    Text(
                      '\$${service.price.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                value: _selectedServices.contains(service),
                onChanged: (checked) {
                  setState(() {
                    if (checked!) {
                      _selectedServices.add(service);
                    } else {
                      _selectedServices.remove(service);
                    }
                    widget.onServicesSelected(_selectedServices);
                  });
                },
              );
            }).toList(),
          );
        }
      },
    );
  }
}
