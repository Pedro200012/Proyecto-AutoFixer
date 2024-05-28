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
  late Future<List<String>> availableTimes;

  @override
  void initState() {
    super.initState();
    availableTimes = Future.value([]);
  }

  Future<List<String>> _fetchAvailableTimes(DateTime date) async {
    try {
      final reservedTurnsSnapshot = await FirebaseFirestore.instance
          .collection('turns')
          .where('ingreso', isGreaterThanOrEqualTo: date)
          .where('ingreso', isLessThan: date.add(Duration(days: 1)))
          .get();

      final reservedTimes = reservedTurnsSnapshot.docs
          .map((doc) => doc.data())
          .where((data) =>
              data.containsKey('ingreso') && data['ingreso'] is Timestamp)
          .map<String>((data) {
        final Timestamp timestamp = data['ingreso'] as Timestamp;
        final DateTime dateTime = timestamp.toDate();
        return DateFormat('HH:00').format(dateTime);
      }).toList();

      final List<String> allTimes = List.generate(
          10, (index) => '${(9 + index).toString().padLeft(2, '0')}:00');

      final availableTimes =
          allTimes.where((time) => !reservedTimes.contains(time)).toList();

      return availableTimes;
    } catch (e) {
      print("Error fetching available times: $e");
      return [];
    }
  }

  Widget _buildSelectDate(BuildContext context) {
    return ListTile(
      title: Text(selectedDate == null
          ? 'Select date'
          : 'Selected date: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}'),
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
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final availableTimes = snapshot.data ?? [];
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
                    .map<DropdownMenuItem<String>>(
                        (value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                    .toList(),
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
