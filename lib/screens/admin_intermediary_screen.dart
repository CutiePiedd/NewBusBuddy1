import 'package:flutter/material.dart';
//import 'package:newbusbuddy/screens/ticket_screen.dart';
import 'package:newbusbuddy/widgets/custom_scaffold.dart';
import 'package:newbusbuddy/screens/DagupanAdmin_ticket.dart'; // Import CustomScaffold

class AdminIntermediaryScreen extends StatelessWidget {
  const AdminIntermediaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      // Use CustomScaffold for consistent background
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20.0), // Adjust horizontal padding as needed
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Align items to the start (top-left)
          children: [
            const SizedBox(height: 50.0), // Space from the top of the screen

            // Add the logo at the top
            Center(
              child: Image.asset(
                'assets/images/logo_white2.png', // Replace with your logo asset path
                height: 50.0,
                fit: BoxFit.contain,
              ),
            ),

            // Space between logo and text
            const SizedBox(height: 20.0),

            // Add the text below the logo
            const Center(
              child: Text(
                'Choose Your',
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white, // Adjust color as needed
                  fontFamily: 'GabrielSans', // Use the desired font
                ),
              ),
            ),
            const Center(
              child: Text(
                'ORIGIN',
                style: TextStyle(
                  fontSize: 55.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Adjust color as needed
                  fontFamily: 'GabrielSans', // Use the desired font
                ),
              ),
            ),
            const SizedBox(height: 20.0), // Space between text and buttons

            // First picture button with text overlaid on top of it
            Center(
              child: GestureDetector(
                onTap: () {
                  // Navigate to the TicketScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DagupanadminTicket()),
                  );
                },
                child: Container(
                  // Set the width and height to the size of the image
                  width: 400.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  child: Stack(
                    children: [
                      // The image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            20), // Ensure image corners match container
                        child: Image.asset(
                          'assets/images/dagupan.png', // Replace with your image asset path
                          fit: BoxFit.cover,
                          width: 400.0, // Match the container width
                          height: 150.0, // Match the container height
                        ),
                      ),
                      // Transparent overlay
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(180, 2, 33, 58)
                              .withOpacity(
                                  0.5), // Transparent navy blue overlay
                          borderRadius: BorderRadius.circular(
                              20), // Match the border radius
                        ),
                      ),
                      // Text on top of the image
                      const Align(
                        alignment: Alignment
                            .center, // Align the text at the top center of the image
                        child: Padding(
                          padding: EdgeInsets.all(
                              10.0), // Optional padding for the text
                          child: Text(
                            'Dagupan',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Adjust color as needed
                              fontFamily: 'GabrielSans', // Use the desired font
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0), // Space between the two buttons

            // Second picture button with text overlaid on top of it
            Center(
              child: GestureDetector(
                onTap: () {
                  // Navigate to the TicketScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DagupanadminTicket()),
                  );
                },
                child: Container(
                  // Set the width and height to the size of the image
                  width: 400.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                  child: Stack(
                    children: [
                      // The image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            20), // Ensure image corners match container
                        child: Image.asset(
                          'assets/images/cubao.png', // Replace with your image asset path
                          fit: BoxFit.cover,
                          width: 400.0, // Match the container width
                          height: 150.0, // Match the container height
                        ),
                      ),
                      // Transparent overlay
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(180, 2, 33, 58)
                              .withOpacity(
                                  0.5), // Transparent navy blue overlay
                          borderRadius: BorderRadius.circular(
                              20), // Match the border radius
                        ),
                      ),
                      // Text on top of the image
                      const Align(
                        alignment: Alignment
                            .center, // Align the text at the top center of the image
                        child: Padding(
                          padding: EdgeInsets.all(
                              10.0), // Optional padding for the text
                          child: Text(
                            'Cubao',
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Adjust color as needed
                              fontFamily: 'GabrielSans', // Use the desired font
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// TODO Implement this library.