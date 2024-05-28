import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationButton extends StatelessWidget {
  final String text;
  final String route;
  final Icon icon;

  const NavigationButton({
    super.key,
    required this.text,
    required this.route,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(text),
      leading: icon,
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => context.push(route),
    );
  }
}
