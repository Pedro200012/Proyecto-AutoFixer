import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DateTimeSelector extends StatefulWidget {
  final ValueChanged<DateTime?> onDateSelected;
  final ValueChanged<String?> onTimeSelected;

  const DateTimeSelector({
    Key? key,
    required this.onDateSelected,
    required this.onTimeSelected,
  }) : super(key: key);

  @override
  _DateTimeSelectorState createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
  DateTime? selectedDate;
  String? selectedHour;
  List<String> reservedTimes = [];

  @override
  void initState() {
    super.initState();
    // Fetch reserved times when the widget is initialized
    _fetchReservedTimes(DateTime.now());
  }

  Future<void> _fetchReservedTimes(DateTime date) async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('reservations')
          .doc('${date.year}-${date.month}-${date.day}')
          .collection('times')
          .where('reserved', isEqualTo: true)
          .get();

      final times = snapshot.docs.map((doc) {
        final data = doc.data();
        if (data.containsKey('time') && data['time'] is String) {
          final timeString = data['time'] as String;
          return timeString;
        } else {
          return null;
        }
      }).where((time) => time != null).cast<String>().toList();

      setState(() {
        reservedTimes = times;
      });
    } catch (e) {
      // Handle errors appropriately
      print("Error fetching reserved times: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
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
                    selectedHour = null;
                    _fetchReservedTimes(selectedDate!);
                  });
                  widget.onDateSelected(selectedDate);
                }
              },
            ),
            Visibility(
              visible: selectedDate != null,
              child: ListTile(
                title: DropdownButtonFormField<String>(
                  value: selectedHour,
                  onChanged: (value) {
                    setState(() {
                      selectedHour = value;
                    });
                    widget.onTimeSelected(selectedHour);
                  },
                  items: [
                    ...reservedTimes, // Add reserved times here
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
            ),
          ],
        ),
      ],
    );
  }
}
