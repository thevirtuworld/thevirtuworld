import 'package:flutter/material.dart';
import 'package:thevirtuworld/features/auth/presentation/screens/register_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // body: Center(child: Text('Splash Screen')),

      // add button that leads to login screen
      body: Center(
        child: ElevatedButton(

          // when button is pressed go to login
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          },
          child: const Text('Go to Login'),
          // add hover effect
          onHover: (hovering) {
            if (hovering) {
              // change color to red



              // change text to 'Go to Login'
            }
          },
           
      
      )


    );
    )
  }
}
