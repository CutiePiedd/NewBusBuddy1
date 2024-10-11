import 'package:flutter/material.dart';
import 'package:newbusbuddy/screens/cubao_ticket_screen.dart';
import 'package:newbusbuddy/screens/intermediary_screen.dart';
import 'package:newbusbuddy/screens/onboarding_screen.dart'; // Import your OnboardingScreen
import 'package:newbusbuddy/screens/welcome_screen.dart'; // Import your WelcomeScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BusBuddy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Set the initial route to the OnboardingScreen
      home: const OnboardingScreen(),
      // Define the routes for your app
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/cubaoTicket': (context) => const CubaoTicketScreen(),
        '/intermediaryScreen': (context) => const IntermediaryScreen(),

        // Add other routes here
      },
    );
  }
}
