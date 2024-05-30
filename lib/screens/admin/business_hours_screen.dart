import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessHoursScreen extends StatefulWidget {
  const BusinessHoursScreen({super.key});

  @override
  _BusinessHoursScreenState createState() => _BusinessHoursScreenState();
}

class _BusinessHoursScreenState extends State<BusinessHoursScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, bool> _openDays = {
    'Monday': false,
    'Tuesday': false,
    'Wednesday': false,
    'Thursday': false,
    'Friday': false,
    'Saturday': false,
    'Sunday': false,
  };

  final Map<String, TimeOfDay?> _openingTimes = {};
  final Map<String, TimeOfDay?> _closingTimes = {};
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchBusinessHours();
  }

  Future<void> _fetchBusinessHours() async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('businessHours').doc('hours').get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        setState(() {
          data.forEach((day, value) {
            _openDays[day] = value['open'];
            if (value['openTime'] != null) {
              _openingTimes[day] = _timeOfDayFromString(value['openTime']);
            }
            if (value['closeTime'] != null) {
              _closingTimes[day] = _timeOfDayFromString(value['closeTime']);
            }
          });
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error loading business hours';
        _isLoading = false;
      });
    }
  }

  Future<void> _saveBusinessHours() async {
    Map<String, dynamic> data = {};
    _openDays.forEach((day, open) {
      data[day] = {
        'open': open,
        'openTime': _openingTimes[day] != null
            ? _timeOfDayToString(_openingTimes[day]!)
            : null,
        'closeTime': _closingTimes[day] != null
            ? _timeOfDayToString(_closingTimes[day]!)
            : null,
      };
    });
    await _firestore.collection('businessHours').doc('hours').set(data);
  }

  TimeOfDay _timeOfDayFromString(String time) {
    final format = RegExp(r'(\d{2}):(\d{2})');
    final match = format.firstMatch(time);
    if (match != null) {
      int hour = int.parse(match.group(1)!);
      int minute = int.parse(match.group(2)!);
      return TimeOfDay(hour: hour, minute: minute);
    }
    return TimeOfDay.now();
  }

  String _timeOfDayToString(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void _pickTime(String day, bool isOpeningTime) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        if (isOpeningTime) {
          _openingTimes[day] = pickedTime;
        } else {
          _closingTimes[day] = pickedTime;
        }
      });
    }
  }

  Widget _buildDayCard(String day) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: _openDays[day]!,
                  onChanged: (value) {
                    setState(() {
                      _openDays[day] = value;
                    });
                  },
                ),
              ],
            ),
            if (_openDays[day]!)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => _pickTime(day, true),
                      child: Text(_openingTimes[day] != null
                          ? _timeOfDayToString(_openingTimes[day]!)
                          : 'Set Opening Time'),
                    ),
                    Text('-'),
                    TextButton(
                      onPressed: () => _pickTime(day, false),
                      child: Text(_closingTimes[day] != null
                          ? _timeOfDayToString(_closingTimes[day]!)
                          : 'Set Closing Time'),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Business Hours'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveBusinessHours,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(child: Text(_errorMessage!))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView(
                    children: _openDays.keys
                        .map((day) => _buildDayCard(day))
                        .toList(),
                  ),
                ),
    );
  }
}
