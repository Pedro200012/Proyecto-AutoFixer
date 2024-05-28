import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:aplicacion_taller/widgets/navigation_button.dart';

class HomeScreenBase extends StatelessWidget {
  final String title;
  final List<NavigationButton> buttons;

  const HomeScreenBase({
    super.key,
    required this.title,
    required this.buttons,
  });

  Future<void> _logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    context.go('/');
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () => _logout(context),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView.separated(
        itemCount: buttons.length,
        itemBuilder: (context, index) => buttons[index],
        separatorBuilder: (context, index) => const SizedBox(height: 10),
      ),
    );
  }
}
