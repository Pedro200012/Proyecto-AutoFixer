import 'package:flutter/material.dart';
import 'package:aplicacion_taller/config/routes/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "AutoFix",
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
