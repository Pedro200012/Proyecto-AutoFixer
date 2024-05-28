import 'package:flutter/material.dart';

class ErrorBody extends StatelessWidget {
  final String errorMessage;

  const ErrorBody({
    super.key,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errorMessage));
  }
}
