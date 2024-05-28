import 'package:flutter/material.dart';

class DateTimeSelector extends StatefulWidget {
  final ValueChanged<DateTime?> onDateSelected;
  final ValueChanged<String?> onTimeSelected;

  const DateTimeSelector({
    super.key,
    required this.onDateSelected,
    required this.onTimeSelected,
  });

  @override
  _DateTimeSelectorState createState() => _DateTimeSelectorState();
}

class _DateTimeSelectorState extends State<DateTimeSelector> {
  DateTime? selectedDate;
  String? selectedHour;

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
                  });
                  widget.onDateSelected(selectedDate);
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
                  widget.onTimeSelected(selectedHour);
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
    );
  }
}
