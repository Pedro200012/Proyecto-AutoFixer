import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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
  List<String> availableTimes = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _fetchAvailableTimes(DateTime date) async {
    try {
      final reservedTurnsSnapshot = await FirebaseFirestore.instance
          .collection('turns')
          .where('ingreso', isGreaterThanOrEqualTo: date)
          .where('ingreso', isLessThan: date.add(Duration(days: 1)))
          .get();

      final reservedTimes = reservedTurnsSnapshot.docs
          .map((doc) {
            final data = doc.data();
            print("Data: $data");
            if (data.containsKey('ingreso') && data['ingreso'] is Timestamp) {
              final Timestamp timestamp = data['ingreso'] as Timestamp;
              final DateTime dateTime = timestamp.toDate();
              final hour = DateFormat('h:00 a')
                  .format(dateTime); // Format hour to 'h:00 AM/PM' format
              return hour;
            } else {
              return null;
            }
          })
          .where((time) => time != null)
          .cast<String>()
          .toList();

      print("Reserved Times: $reservedTimes");

      // Generate available times
      final List<String> allTimes = [
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
      ];

      var availableTimes =
          allTimes.where((time) => !reservedTimes.contains(time)).toList();

      print("Available Times: $availableTimes");

      setState(() {
        this.availableTimes = availableTimes;
      });
    } catch (e) {
      // Handle errors appropriately
      print("Error fetching available times: $e");
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
                    _fetchAvailableTimes(selectedDate!);
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
                  items: availableTimes
                      .map<DropdownMenuItem<String>>((String value) {
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
