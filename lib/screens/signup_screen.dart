import 'package:flutter/material.dart';
import 'package:newbusbuddy/screens/signin_screen.dart';
//import 'package:newbusbuddy/widgets/custom_circular_checkbox.dart';
import 'package:newbusbuddy/widgets/custom_scaffold.dart';
import 'package:newbusbuddy/api_service.dart'; // Import the ApiService

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formSignUpKey = GlobalKey<FormState>();
  bool acceptTerms = false;
  Color buttonColor = const Color.fromARGB(255, 213, 12, 12);
  bool _obscurePassword = true;
  bool _isContainerMovedUp = false;

  String _fullName = '';
  String _email = '';
  String _password = '';
  final _apiService = ApiService();

  Future<void> _register() async {
    if (_formSignUpKey.currentState!.validate() && acceptTerms) {
      try {
        final success =
            await _apiService.registerUser(_fullName, _email, _password);
        if (success['success'] == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration Successful')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(success['message'])),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } else if (!acceptTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the processing of personal data'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Image.asset(
            'assets/images/logo new (1).png',
            height: 220.0,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 25.0),
          Expanded(
            flex: 20,
            child: GestureDetector(
              child: Container(
                padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 10.0),
                margin: EdgeInsets.only(top: _isContainerMovedUp ? 100 : 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formSignUpKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome!',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 12, 12, 12),
                            fontFamily: 'GabrielSans',
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Create your account',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color.fromARGB(247, 11, 11, 11),
                            fontFamily: 'GabrielSans',
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        // Full Name input field
                        TextFormField(
                          onChanged: (value) =>
                              _fullName = value, // Fixed variable name
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Full Name';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
                              color: Color.fromARGB(208, 14, 2, 51),
                              size: 18.0,
                            ),
                            hintText: 'Enter your Full Name',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                              fontFamily: 'New',
                              fontSize: 13.0,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(235, 244, 211, 159),
                              ),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(235, 244, 211, 159),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            fillColor: Color.fromARGB(235, 244, 211, 159),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        // Email input field
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Email';
                            } else if (!RegExp(
                                    r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                .hasMatch(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _email = value; // Save the input value
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.email,
                              color: Color.fromARGB(208, 14, 2, 51),
                              size: 18.0,
                            ),
                            hintText: 'Enter your Email',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                              fontFamily: 'New',
                              fontSize: 13.0,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(235, 244, 211, 159),
                              ),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(235, 244, 211, 159),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            fillColor: Color.fromARGB(235, 244, 211, 159),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 15.0),

                        // Password input field with visibility toggle
                        TextFormField(
                          obscureText: _obscurePassword,
                          obscuringCharacter: '*',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            _password = value; // Save the input value
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color.fromARGB(208, 14, 2, 51),
                              size: 18.0,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color.fromARGB(208, 14, 2, 51),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            hintText: 'Enter Password',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                              fontFamily: 'New',
                              fontSize: 13.0,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(235, 244, 211, 159),
                              ),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(235, 244, 211, 159),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            fillColor: Color.fromARGB(235, 244, 211, 159),
                            filled: true,
                          ),
                        ),

                        const SizedBox(height: 15.0),
                        // Inside the Form widget, add this after the Password input field

// Confirm Password input field with visibility toggle
                        TextFormField(
                          obscureText: _obscurePassword,
                          obscuringCharacter: '*',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your Password';
                            } else if (value != _password) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            // You don't need to store this in a separate variable
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Color.fromARGB(208, 14, 2, 51),
                              size: 18.0,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: const Color.fromARGB(208, 14, 2, 51),
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            hintText: 'Confirm Password',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                              fontFamily: 'New',
                              fontSize: 13.0,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(235, 244, 211, 159),
                              ),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(235, 244, 211, 159),
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            fillColor: Color.fromARGB(235, 244, 211, 159),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 15.0),

                        // Accept Terms Checkbox

                        // Sign up button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(70),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                            ),
                            onPressed:
                                _register, // Call the _register function here
                            child: const Text(
                              'SIGN UP',
                              style: TextStyle(
                                fontFamily: 'GabrielSans',
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25.0),

                        // Already have an account? Sign in
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an account?',
                              style: TextStyle(
                                color: Colors.black54,
                                fontFamily: 'GabrielSans',
                                fontSize: 13.0,
                              ),
                            ),
                            const SizedBox(width: 5.0),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Log in',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'New',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
