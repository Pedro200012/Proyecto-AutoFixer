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
  late Future<List<String>> availableTimes = Future.value([]);

  @override
  void initState() {
    super.initState();
  }

  Future<List<String>> _fetchAvailableTimes(DateTime date) async {
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
              final hour = DateFormat('HH:00').format(dateTime);
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
        '09:00',
        '10:00',
        '11:00',
        '12:00',
        '13:00',
        '14:00',
        '15:00',
        '16:00',
        '17:00',
        '18:00',
      ];

      var availableTimes =
          allTimes.where((time) => !reservedTimes.contains(time)).toList();

      print("Available Times: $availableTimes");

      return availableTimes;
    } catch (e) {
      // Handle errors appropriately
      print("Error fetching available times: $e");
      return [];
    }
  }

  Widget _buildSelectDate(BuildContext context) {
    return ListTile(
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
            availableTimes = _fetchAvailableTimes(selectedDate!);
          });
          widget.onDateSelected(selectedDate);
        }
      },
    );
  }

  Widget _buildSelectHour() {
    return Visibility(
      visible: selectedDate != null,
      child: FutureBuilder<List<String>>(
        future: availableTimes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While data is loading
            return const Center(child: CircularProgressIndicator()); // or any other loading indicator
          } else if (snapshot.hasError) {
            // If there's an error
            return Text('Error: ${snapshot.error}');
          } else {
            // If data is successfully fetched
            List<String> availableTimes = snapshot.data ?? [];
            return ListTile(
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
            );
          }
        },
      ),
    );
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
            _buildSelectDate(context),
            _buildSelectHour(),
          ],
        ),
      ],
    );
  }
}
