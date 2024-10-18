import 'package:flutter/material.dart';
import 'package:newbusbuddy/screens/history_screen.dart';
//import 'package:newbusbuddy/screens/intermediary_screen.dart';
import 'package:newbusbuddy/screens/user_tickets_screen.dart';
import 'package:newbusbuddy/widgets/custom_scaffold.dart';

class TicketReceiptScreen extends StatelessWidget {
  final String origin;
  final String destination;
  final String busNo;
  final String seatNo;
  final String date;
  final double totalFare;
  final List<int> selectedSeats;
  final String tripHours;

  const TicketReceiptScreen({
    super.key,
    required this.origin,
    required this.destination,
    required this.busNo,
    required this.seatNo,
    required this.date,
    required this.totalFare,
    required this.selectedSeats,
    required this.tripHours,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Center(
        child: Column(
          children: [
            // Logo
            Image.asset(
              'assets/images/logo_white2.png', // Replace with your logo path
              height: 30,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 25),

            // Buttons
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TicketReceiptScreen(
                              origin: origin,
                              busNo: busNo,
                              destination: destination,
                              seatNo: seatNo,
                              totalFare: totalFare,
                              date: date,
                              selectedSeats: selectedSeats,
                              tripHours: tripHours,
                            ),
                          ),
                        );
                        // Action for first button
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 20.0,
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 246, 204, 35), // Blue
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(70),
                            bottomLeft: Radius.circular(70),
                          ),
                        ),
                      ),
                      child: const Text('Ongoing',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryTicketReceiptScreen(
                              origin: origin, // Pass the correct value
                              busNo: busNo, // Pass the correct value
                              destination: destination,
                              seatNo: seatNo,
                              totalFare:
                                  totalFare, // Ensure totalFare is a valid double
                              date: date,
                              selectedSeats: selectedSeats,
                              tripHours: tripHours,
                            ),
                          ),
                        );
                        // Action for second button
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 20.0,
                        ),
                        backgroundColor:
                            Color.fromARGB(255, 255, 122, 6), // Dark color
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(70),
                            bottomRight: Radius.circular(70),
                          ),
                        ),
                      ),
                      child: const Text('Ended',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 80), // Space

            // Ticket details container
            Container(
              width: 370, // Container width
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white, // White background
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Row
                  Row(
                    children: [
                      const Expanded(
                        child: Row(
                          children: [
                            Text(
                              'Status:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Segoe UI',
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Active',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'New',
                                color: Color.fromARGB(255, 18, 86, 117),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Green Circle
                      Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Colors.green, // Green color for the active status
                        ),
                      ),
                    ],
                  ),
                  // Origin and Destination Row
                  Row(
                    children: [
                      Text(
                        '$origin ',
                        style: const TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 18,
                        ),
                      ),
                      const Icon(Icons.arrow_forward, size: 30),
                      Text(
                        ' $destination',
                        style: const TextStyle(
                          fontFamily: 'Segoe UI',
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.black, thickness: 3),

                  // Bus No and Departure Time
                  _buildTwoColumnRow(
                    'Service Class:',
                    'Regular Aircon',
                  ),
                  const SizedBox(height: 6.0),

                  // Service Class and Trip Hours
                  _buildTwoColumnRow(
                    'Bus No. :',
                    busNo,
                  ),
                  const SizedBox(height: 6.0),
                  _buildTwoColumnRow(
                    'Departure: :',
                    '5:00 A.M.',
                  ),
                  const SizedBox(height: 6.0),
                  _buildTwoColumnRow(
                    'Trip Hours :',
                    tripHours,
                  ),
                  const SizedBox(height: 6.0),
                  const Divider(color: Colors.black, thickness: 3),

                  _buildTwoColumnRow(
                      'Selected Seats:', selectedSeats.join(', ')),
                  _buildTwoColumnRow('Amount to pay:', 'PHP $totalFare'),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
            const SizedBox(height: 100.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Action for home button (navigate to home or intermediary screen)
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UserTicketsScreen())); // Replace with your actual route
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 20.0,
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 255, 25, 25), // Blue
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(70),
                            bottomLeft: Radius.circular(70),
                          ),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: Color.fromARGB(255, 251, 251, 251),
                            size: 25,
                          ), // Home icon
                          SizedBox(width: 8), // Space between icon and text
                          // Optional: Add text beside the icon
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryTicketReceiptScreen(
                              origin: origin, // Pass the correct value
                              busNo: busNo, // Pass the correct value
                              destination: destination,
                              seatNo: seatNo,
                              totalFare:
                                  totalFare, // Ensure totalFare is a valid double
                              date: date,
                              selectedSeats: selectedSeats,
                              tripHours: tripHours,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30.0,
                          vertical: 20.0,
                        ),
                        backgroundColor: const Color.fromARGB(
                            255, 255, 255, 255), // Dark color
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(70),
                            bottomRight: Radius.circular(70),
                          ),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.receipt,
                            color: Color.fromARGB(255, 255, 18, 18),
                            size: 25,
                          ), // Optional: Add text beside the icon
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create two-column rows for clean layout
  Widget _buildTwoColumnRow(String term1, String definition1,
      [String? term2, String? definition2]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                term1,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Segoe UI',
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                definition1,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'New',
                  color: Color.fromARGB(255, 18, 86, 117),
                ),
              ),
            ],
          ),
        ),
        if (term2 != null && definition2 != null)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  term2,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Segoe UI',
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  definition2,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 18, 86, 117),
                    fontFamily: 'New',
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
