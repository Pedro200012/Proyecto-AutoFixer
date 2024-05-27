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
    _selectedTime = const TimeOfDay(hour: 9, minute: 0);
    _fetchReservedTimes(_selectedDate);
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
            onPressed: _handleDateTimeSelection,
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
          _fetchReservedTimes(_selectedDate);
        });
      },
    );
  }

  Widget _buildTimePicker() {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          final hour = index + 9;
          final time = TimeOfDay(hour: hour, minute: 0);
          final dateTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, hour, 0);

          if (_isTimeAvailable(dateTime)) {
            return ListTile(
              title: Text(time.format(context)),
              onTap: () {
                setState(() {
                  _selectedTime = time;
                });
              },
              selected: _selectedTime == time,
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
    return true;
  }

  void _fetchReservedTimes(DateTime date) async {
    try {
      final snapshot = await _firestore
          .collection('reservations')
          .doc('${date.year}-${date.month}-${date.day}')
          .collection('times')
          .where('reserved', isEqualTo: true)
          .get();

      final times = snapshot.docs.map((doc) {
        final data = doc.data();
        if (data.containsKey('time') && data['time'] is String) {
          final timeString = data['time'] as String;
          final timeParts = timeString.split(':');
          if (timeParts.length == 2) {
            final hour = int.parse(timeParts[0]);
            final minute = int.parse(timeParts[1]);
            return TimeOfDay(hour: hour, minute: minute);
          } else {
            print("El campo 'time' del documento ${doc.id} no tiene el formato correcto.");
            return null;
          }
        } else {
          print("El documento ${doc.id} no tiene un campo 'time' válido.");
          return null;
        }
      }).where((time) => time != null).cast<TimeOfDay>().toList();

      setState(() {
        _reservedTimes[DateTime(date.year, date.month, date.day)] = times;
      });
    } catch (e) {
      // Manejar errores de manera apropiada
      print("Error fetching reserved times: $e");
    }
  }

  void _handleDateTimeSelection() {
    final selectedDateTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, _selectedTime.hour, _selectedTime.minute);
    widget.onDateTimeSelected?.call(selectedDateTime);
    Navigator.pop(context);
  }
}
