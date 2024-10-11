import 'dart:async'; // For Timer
import 'package:flutter/material.dart';
import 'package:newbusbuddy/screens/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapUp: (details) {
          // Get the screen width and calculate the tap position
          final screenWidth = MediaQuery.of(context).size.width;
          final tapPosition = details.globalPosition.dx;

          if (tapPosition > screenWidth / 2) {
            // Tap on the right side - go to the next page
            if (_currentPage < 2) {
              _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            }
          } else {
            // Tap on the left side - go to the previous page
            if (_currentPage > 0) {
              _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            }
          }
        },
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                    if (page == 2) {
                      _startAutoNavigation();
                    }
                  });
                },
                children: [
                  _buildPage(
                    text: 'Secure Your Seats Effortlessly And Skip The Lines.',
                    textPosition: Alignment.topLeft,
                    textAlign: TextAlign.left,
                    fontFamily: 'Segoe Ui',
                    fontSize: 33,
                    fontWeight: FontWeight.w800,
                    imagePath:
                        'assets/images/8a53dc94-0893-4126-9cb0-92b03393b6f3.jpg',
                    overlayColors: [
                      const Color.fromARGB(167, 12, 12, 12),
                      const Color.fromARGB(221, 0, 0, 0)
                    ], // Gradient colors
                    overlayOpacity: 0.4,
                  ),
                  _buildPage(
                    text: 'Enjoy A Smooth, Stress Free Journey.',
                    textPosition: Alignment.centerLeft,
                    textAlign: TextAlign.left,
                    fontFamily: 'Segoe Ui',
                    fontSize: 33,
                    fontWeight: FontWeight.w800,
                    imagePath: 'assets/images/enjoy.jpg',
                    overlayColors: [
                      const Color.fromARGB(218, 12, 12, 12),
                      const Color.fromARGB(235, 0, 0, 0)
                    ], // Gradient colors
                    overlayOpacity: 0.5,
                  ),
                  _buildPage(
                    text: 'Reserve With Ease, Ride With Peace.',
                    textPosition: Alignment.bottomRight,
                    textAlign: TextAlign.right,
                    fontFamily: 'Segoe Ui',
                    fontSize: 33,
                    fontWeight: FontWeight.w800,
                    imagePath: 'assets/images/cp.jpg',
                    overlayColors: [
                      const Color.fromARGB(192, 12, 12, 12),
                      const Color.fromARGB(221, 0, 0, 0)
                    ], // Gradient colors
                    overlayOpacity: 0.5,
                  ),
                ],
              ),
            ),
            // Add a Container for the dots
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      width: _currentPage == index ? 12.0 : 8.0,
      height: _currentPage == index ? 12.0 : 8.0,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.white : Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  // Helper method to build onboarding pages with customizable text, alignment, etc.
  Widget _buildPage({
    required String text,
    required Alignment textPosition,
    required TextAlign textAlign,
    required String fontFamily,
    required double fontSize,
    required FontWeight fontWeight,
    required String imagePath,
    required List<Color> overlayColors,
    required double overlayOpacity,
  }) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ClipRRect(
            child: Stack(
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                // Gradient overlay using BoxDecoration
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: overlayColors,
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.0,
                        overlayOpacity
                      ], // Adjust stops to create a gradient effect
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: textPosition,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: fontFamily,
                fontWeight: fontWeight,
                color: Colors.white,
              ),
              textAlign: textAlign,
            ),
          ),
        ),
      ],
    );
  }

  // Navigate to WelcomeScreen after 2 seconds when reaching the last page
  void _startAutoNavigation() {
    Timer(const Duration(seconds: 1), () {
      // Reduced duration for auto-navigation
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }
}
