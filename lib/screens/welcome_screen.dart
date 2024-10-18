import 'package:flutter/material.dart';
import 'package:newbusbuddy/screens/admin_signin_screen.dart';
import 'package:newbusbuddy/widgets/custom_scaffold.dart';
import 'package:newbusbuddy/widgets/welcome_button.dart';
import 'package:newbusbuddy/screens/signin_screen.dart'; // Import SignInScreen
import 'package:newbusbuddy/screens/signup_screen.dart';
//import 'package:newbusbuddy/screens/admin_signin.dart';
// Import SignUpScreen

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.topCenter, // Align towards the top-center
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0), // Add top margin
                child: Image.asset(
                  'assets/images/logo new (1).png', // Path to your logo image
                  width: MediaQuery.of(context).size.width *
                      0.5, // Adjust width as needed
                  height: MediaQuery.of(context).size.height *
                      0.5, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Align buttons at the bottom
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: WelcomeButton(
                    buttonText: 'Log in',
                    onTap: (context) {
                      // Navigate to SignInScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()),
                      );
                    },
                    color: Colors.transparent,
                    textColor: Colors.white,
                    borderColor: Colors.white, // White border for "Log in"
                    textStyle: const TextStyle(
                      fontFamily: 'New', // Use your custom font
                      fontSize: 18, // Adjust font size
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5), // Add space between buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: WelcomeButton(
                    buttonText: 'Create an account',
                    onTap: (context) {
                      // Navigate to SignUpScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpScreen()),
                      );
                    },
                    color: Colors.white, // White background
                    textColor:
                        const Color.fromARGB(255, 13, 13, 13), // Black text
                    borderColor: Colors.white, // White border
                    textStyle: const TextStyle(
                      fontFamily: 'New', // Use your custom font
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 5), // Add space between buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: WelcomeButton(
                    buttonText: 'Admin',
                    onTap: (context) {
                      // Navigate to SignUpScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminSignin()),
                      );
                    },
                    color: Colors.white, // White background
                    textColor:
                        const Color.fromARGB(255, 13, 13, 13), // Black text
                    borderColor: Colors.white, // White border
                    textStyle: const TextStyle(
                      fontFamily: 'New', // Use your custom font
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
