import 'package:flutter/material.dart';

class TurnCreate extends StatefulWidget {
  const TurnCreate({super.key});

  @override
  State<TurnCreate> createState() => _TurnCreateState();
}

class _TurnCreateState extends State<TurnCreate> {
  String selectedVehicle = 'Toyota Corolla';
  List<String> selectedServices = [];
  Map<String, double> servicePrices = {
    'Oil Change': 50.0,
    'Brake Repair': 100.0,
    'Engine Tune-up': 150.0,
  };
  DateTime? selectedDate;
  String? selectedHour;

  double getSubtotal() {
    double subtotal = 0.0;
    selectedServices.forEach((service) {
      subtotal += servicePrices[service]!;
    });
    return subtotal;
  }

  bool isSubmitEnabled() {
    return selectedVehicle.isNotEmpty &&
        selectedServices.isNotEmpty &&
        selectedDate != null &&
        selectedHour != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear turno'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ExpansionTile(
              title: const Text(
                'Select vehicle',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              initiallyExpanded: true,
              children: [
                RadioListTile(
                  title: const Text('Toyota Corolla'),
                  value: 'Toyota Corolla',
                  groupValue: selectedVehicle,
                  onChanged: (value) {
                    setState(() {
                      selectedVehicle = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Honda Civic'),
                  value: 'Honda Civic',
                  groupValue: selectedVehicle,
                  onChanged: (value) {
                    setState(() {
                      selectedVehicle = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Ford Mustang'),
                  value: 'Ford Mustang',
                  groupValue: selectedVehicle,
                  onChanged: (value) {
                    setState(() {
                      selectedVehicle = value.toString();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            ExpansionTile(
              title: const Text(
                'Select service',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              initiallyExpanded: true,
              children: [
                for (var service in servicePrices.keys)
                  CheckboxListTile(
                    title: Row(
                      children: [
                        Text(service),
                        const Spacer(),
                        Text(
                          '\$${servicePrices[service]!.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    value: selectedServices.contains(service),
                    onChanged: (checked) {
                      setState(() {
                        if (checked!) {
                          selectedServices.add(service);
                        } else {
                          selectedServices.remove(service);
                        }
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(height: 16.0),
            ExpansionTile(
              title: const Text(
                'Select date and time',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              initiallyExpanded: true,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(selectedDate == null
                          ? 'Select date'
                          : 'Selected date: ${selectedDate.toString().substring(0, 10)}'),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(DateTime.now().year + 1),
                        );
                        if (pickedDate != null && pickedDate != selectedDate) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                    ),
                    ListTile(
                      title: DropdownButtonFormField<String>(
                        value: selectedHour,
                        onChanged: (value) {
                          setState(() {
                            selectedHour = value;
                          });
                        },
                        items: [
                          '9:00 AM',
                          '10:00 AM',
                          '11:00 AM',
                          '12:00 PM',
                          '1:00 PM',
                          '2:00 PM',
                          '3:00 PM',
                          '4:00 PM',
                          '5:00 PM',
                          '6:00 PM',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          labelText: 'Select hour',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Subtotal: \$${getSubtotal().toStringAsFixed(2)}',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: isSubmitEnabled()
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Success'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
