import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'theme/app_theme.dart';
import 'screens/auth/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SPK Magang',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      // App dimulai dari LoginScreen.
      // Nanti kalau sudah ada sistem auth (token disimpan di SharedPreferences),
      // di sini kita bisa cek token dulu sebelum redirect ke Dashboard atau Login.
      home: const LoginScreen(),
    );
  }
}
