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

  Future<List<String>> _fetchReservedTimes(DateTime date) async {
    try {
      final reservedTurnsSnapshot = await FirebaseFirestore.instance
          .collection('turns')
          .where('ingreso', isGreaterThanOrEqualTo: date)
          .where('ingreso', isLessThan: date.add(const Duration(days: 1)))
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

      return reservedTimes;
    } catch (e) {
      print("Error fetching reserved times: $e");
      return [];
    }
  }

  Future<List<String>> _calculateAvailableTimes(DateTime date) async {
    final List<String> allTimes = List.generate(
        10, (index) => '${(9 + index).toString().padLeft(2, '0')}:00');
    final reservedTimes = await _fetchReservedTimes(date);
    return allTimes.where((time) => !reservedTimes.contains(time)).toList();
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
            availableTimes = _calculateAvailableTimes(selectedDate!);
          });
          widget.onDateSelected(selectedDate);
        }
      },
    );
  }

  void _showAvailableTimesDialog(BuildContext context, List<String> times) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Hour'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: times.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(times[index]),
                  onTap: () {
                    setState(() {
                      selectedHour = times[index];
                    });
                    widget.onTimeSelected(selectedHour);
                    Navigator.pop(context); // Close the dialog
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSelectHour() {
    return FutureBuilder<List<String>>(
      future: availableTimes,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          final availableTimes = snapshot.data ?? [];
          return ListTile(
            title: Text(selectedHour == null
                ? 'Select hour'
                : 'Selected hour: $selectedHour'),
            trailing: Icon(Icons.access_time,
                color: selectedDate == null
                    ? Colors.grey
                    : Theme.of(context).iconTheme.color),
            onTap: selectedDate == null
                ? null
                : () {
                    if (availableTimes.isNotEmpty) {
                      _showAvailableTimesDialog(context, availableTimes);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('No available times'),
                      ));
                    }
                  },
          );
        }
      },
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
