import 'package:flutter/material.dart';
import 'package:newbusbuddy/screens/admin_api.dart';
import 'package:newbusbuddy/widgets/custom_scaffold.dart';
import 'package:newbusbuddy/screens/admin_intermediary_screen.dart';

class AdminSignin extends StatefulWidget {
  const AdminSignin({super.key});

  @override
  State<AdminSignin> createState() => _AdminSignin();
}

class _AdminSignin extends State<AdminSignin> {
  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;
  Color buttonColor = const Color.fromARGB(255, 8, 2, 66);
  bool _isContainerMovedUp = false;
  bool _obscurePassword = true;

  final _apiService = AdminApi();

  // Controllers for user input
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    if (_formSignInKey.currentState!.validate()) {
      final email = _emailController.text; // Get email from controller
      final password = _passwordController.text; // Get password from controller

      try {
        final success = await _apiService.loginUser(email, password);
        if (success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const AdminIntermediaryScreen()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login Failed')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    // Dispose of controllers when not needed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Image.asset(
            'assets/images/logo_white.png',
            height: 250.0,
            fit: BoxFit.contain,
          ),
          Expanded(
            flex: 9,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _isContainerMovedUp = !_isContainerMovedUp;
                });
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
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
                    key: _formSignInKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 12, 12, 12),
                            fontFamily: 'GabrielSans',
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Log in to your account',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color.fromARGB(247, 11, 11, 11),
                            fontFamily: 'GabrielSans',
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _emailController, // Added controller
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
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.person,
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
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(174, 170, 189, 232)),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(174, 170, 189, 232),
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            fillColor: const Color.fromARGB(174, 170, 189, 232),
                            filled: true,
                          ),
                        ),
                        const SizedBox(height: 15.0),

                        // Password field with visibility toggle
                        TextFormField(
                          controller: _passwordController, // Added controller
                          obscureText: _obscurePassword,
                          obscuringCharacter: '*',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
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
                                size: 18.0,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            hintText: 'Enter your Password',
                            hintStyle: const TextStyle(
                              color: Colors.black26,
                              fontFamily: 'New',
                              fontSize: 13.0,
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(174, 170, 189, 232)),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(174, 170, 189, 232),
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(70),
                            ),
                            fillColor: const Color.fromARGB(174, 170, 189, 232),
                            filled: true,
                          ),
                        ),

                        const SizedBox(height: 15.0),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(70),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                            ),
                            child: const Text(
                              'LOG IN',
                              style: TextStyle(
                                fontFamily: 'GabrielSans',
                                color: Colors.white,
                              ),
                            ),
                          ),
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
