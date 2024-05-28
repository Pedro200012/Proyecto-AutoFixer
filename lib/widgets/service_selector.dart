// lib/widgets/service_selector.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aplicacion_taller/entities/service.dart';

class ServiceSelector extends StatefulWidget {
  final List<Service> services;
  final ValueChanged<Set<Service>> onServicesSelected;

  const ServiceSelector({
    super.key,
    required this.services,
    required this.onServicesSelected,
  });

  static Future<List<Service>> loadServices() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('services').get();
    return snapshot.docs.map((doc) => Service.fromFirestore(doc)).toList();
  }

  @override
  _ServiceSelectorState createState() => _ServiceSelectorState();
}

class _ServiceSelectorState extends State<ServiceSelector> {
  final Set<Service> _selectedServices = {};

  @override
  Widget build(BuildContext context) {
    if (widget.services.isEmpty) {
      return const Center(child: Text('No hay servicios disponibles'));
    } else {
      return ExpansionTile(
        title: const Text(
          'Seleccionar servicios',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        initiallyExpanded: true,
        children: widget.services.map((service) {
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
  }
}
