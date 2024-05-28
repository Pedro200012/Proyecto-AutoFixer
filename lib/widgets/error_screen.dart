import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final AppBar appBar;
  final String errorMessage;

  const ErrorScreen({
    super.key,
    required this.appBar,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Center(child: Text(errorMessage)),
    );
  }
}
