import 'package:flutter/material.dart';
import 'package:thevirtuworld/features/auth/presentation/screens/register_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const RegisterScreen()),
            );
          },
          child: const Text('Go to Signup'),
          onHover: (hovering) {
            // Add hover effect logic here if needed
          },
        ),
      ),
    );
  }
}
