import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RepairRequestCalendar extends StatefulWidget {
  final Function(DateTime)? onDateTimeSelected;

  const RepairRequestCalendar({Key? key, this.onDateTimeSelected}) : super(key: key);

  @override
  _SelectDateTimeScreenState createState() => _SelectDateTimeScreenState();
}

class _SelectDateTimeScreenState extends State<RepairRequestCalendar> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<DateTime, List<TimeOfDay>> _reservedTimes = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = const TimeOfDay(hour: 9, minute: 0); // Inicializar a las 9:00 AM
    _fetchReservedTimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Fecha y Hora'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildCalendar(),
          const SizedBox(height: 20),
          _buildTimePicker(),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              _handleDateTimeSelection();
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2024, 1, 1),
      lastDay: DateTime.utc(2024, 12, 31),
      focusedDay: _selectedDate,
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

Widget _buildTimePicker() {
  return Expanded(
    child: ListView.builder(
      itemCount: 10, // Horas disponibles de 9 a 18
      itemBuilder: (context, index) {
        final hour = index + 9; // Empezar desde las 9:00 AM
        final time = TimeOfDay(hour: hour, minute: 00);
        final dateTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, hour, 00);

        if (_isTimeAvailable(dateTime)) {
          return ListTile(
            title: Text(time.format(context)),
            onTap: () {
              setState(() {
                _selectedTime = time;
              });
            },
            selected: _selectedTime == time, // Resaltar el tiempo seleccionado
          );
        } else {
          return const SizedBox(); // No mostrar horario si está reservado
        }
      },
    ),
  );
}

  bool _isTimeAvailable(DateTime dateTime) {
    final times = _reservedTimes[DateTime(dateTime.year, dateTime.month, dateTime.day)];
    if (times != null) {
      final selectedTime = TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
      return !times.contains(selectedTime);
    }
    return true; // Si no hay horarios reservados para ese día, está disponible
  }

void _fetchReservedTimes() async {
  final snapshot = await _firestore.collection('reservations').get();
  snapshot.docs.forEach((doc) {
    final date = DateTime.parse(doc.id);
    final times = (doc['times'] as List<dynamic>).map((time) {
      final hour = (time['hour'] as int);
      final minute = (time['minute'] as int);
      return TimeOfDay(hour: hour, minute: minute);
    }).toList();
    if (isSameDay(date, _selectedDate)) {
      _reservedTimes[_selectedDate] = times;
    }
  });
}


  void _handleDateTimeSelection() {
    final selectedDateTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _selectedTime.hour, _selectedTime.minute);
    widget.onDateTimeSelected?.call(selectedDateTime);
    Navigator.pop(context);
  }
}
