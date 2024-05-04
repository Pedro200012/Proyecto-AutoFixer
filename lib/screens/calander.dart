import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class RepairRequestCalendar extends StatefulWidget {
  const RepairRequestCalendar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RepairRequestCalendarState createState() => _RepairRequestCalendarState();
}

class _RepairRequestCalendarState extends State<RepairRequestCalendar> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendario de Reparaciones'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Seleccione una fecha para reservar',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          _buildCalendar(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _handleDateSelection(_selectedDate);
            },
            child: const Text('Reservar fecha'),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      focusedDay: _selectedDate,
      firstDay: DateTime.utc(2024, 1, 1),
      lastDay: DateTime.utc(2024, 12, 31),
      calendarFormat: CalendarFormat.month,
      selectedDayPredicate: (day) {
         return isSameDay(_selectedDate, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _selectedDate = selectedDay;
        });
      },
    );
  }

  void _handleDateSelection(DateTime selectedDate) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Fecha seleccionada'),
        content: Text('Ha seleccionado la fecha: ${selectedDate.toString()}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
