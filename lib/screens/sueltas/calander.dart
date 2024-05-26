import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RepairRequestCalendar extends StatefulWidget {
  final Function(DateTime)? onDateSelected; // Nuevo callback para la fecha seleccionada

  const RepairRequestCalendar({Key? key, this.onDateSelected}) : super(key: key);

  @override
  _RepairRequestCalendarState createState() => _RepairRequestCalendarState();
}

class _RepairRequestCalendarState extends State<RepairRequestCalendar> {
  late DateTime _selectedDate;
  final List<String> _availableTimes = List.generate(10, (index) => '${10 + index}:00');
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

  void _handleDateSelection(DateTime selectedDate) async {
    // Si se proporcionó una función de devolución de llamada, llámala con la fecha seleccionada
    widget.onDateSelected?.call(selectedDate);

    List<String> reservedTimes = await _getReservedTimes(selectedDate);
    List<String> availableTimes = _availableTimes.where((time) => !reservedTimes.contains(time)).toList();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Horarios disponibles'),
        content: availableTimes.isEmpty
            ? const Text('No hay horarios disponibles para esta fecha.')
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: availableTimes.map((time) {
                  return ListTile(
                    title: Text(time),
                    onTap: () => _reserveTime(time),
                  );
                }).toList(),
              ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Regresar a la pantalla anterior (SelectService)
            },
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  Future<List<String>> _getReservedTimes(DateTime date) async {
    String formattedDate = "${date.year}-${date.month}-${date.day}";
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('reservations')
        .doc(formattedDate)
        .collection('times')
        .get();

    List<String> reservedTimes = [];
    for (var doc in snapshot.docs) {
      reservedTimes.add(doc['time']);
    }
    return reservedTimes;
  }

  void _reserveTime(String time) async {
    User? user = _auth.currentUser;
    if (user == null) {
      // Handle user not logged in
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Reserva confirmada'),
          content: Text('Ha reservado el horario: $time'),
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
      return;
    }

    String formattedDate = "${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}";
    DocumentReference docRef = FirebaseFirestore.instance
        .collection('reservations')
        .doc(formattedDate)
        .collection('times')
        .doc(time);

    await docRef.set({
      'time': time,
      'reserved': true,
      'user_id': user.uid,
    });

    Navigator.pop(context); // Regresar a la pantalla anterior (SelectService)

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Reserva confirmada'),
        content: Text('Ha reservado el horario: $time'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  
}