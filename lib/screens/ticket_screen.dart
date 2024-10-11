import 'package:flutter/material.dart';
import 'package:newbusbuddy/screens/seat_selection.dart';
import 'package:newbusbuddy/widgets/custom_scaffold.dart';

class TicketScreen extends StatelessWidget {
  const TicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Image.asset(
              'assets/images/logo_white2.png',
              height: 50.0,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 20.0),
          const Center(
            child: Text(
              'Select Your Destination',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: 'GabrielSans',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildTicket(
                  'Dagupan',
                  'Quezon City, Manila',
                  ' 101',
                  'Seat No: 12A',
                  'Date: 2024-10-01',
                  'Price: PHP 1200',
                  'Regular Aircon',
                  context,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicket(
    String origin,
    String destination,
    String busNo,
    String seatNo,
    String date,
    String price,
    String busType,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () => _showSeatSelectionBottomSheet(
          context, origin, destination, busNo, seatNo, date, price, busType),
      child: Container(
        height: 180.0,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  origin,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4.0),
                const Icon(
                  Icons.arrow_forward,
                  size: 25,
                ),
                const SizedBox(width: 4.0),
                Text(
                  destination,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
              thickness: 3,
            ),
            const SizedBox(height: 6.0),
            _buildTwoColumnRow('Bus No.', busNo, 'Departure', '5:00 A.M.'),
            const SizedBox(height: 6.0),
            _buildTwoColumnRow(
                'Service Class', 'Regular Aircon', 'Trip Hours', '5 Hours'),
            const SizedBox(height: 6.0),
            _buildTwoColumnRow(
                'Terminal', 'Dagupan, Pangasinan', 'Base Fare', price),
            const SizedBox(height: 6.0),
            _buildTwoColumnRow('Destination', destination),
          ],
        ),
      ),
    );
  }

  void _showSeatSelectionBottomSheet(
      BuildContext context,
      String origin,
      String destination,
      String busNo,
      String seatNo,
      String date,
      String price,
      String busType) {
    int selectedSeats = 1; // Default selected seats
    const double baseFare = 498.00; // Fixed base fare

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16.0),
                  bottom: Radius.circular(16.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align content to the left
                children: [
                  // First Row: Number of Seats and Base Fare
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Number of Seats
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 10.0),
                          const Text(
                            'Number of Seats',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'GabrielSans',
                            ),
                          ),
                          // Inside the Number of Seats Column

                          Row(
                            children: [
                              // Minus Button
                              const SizedBox(
                                  width:
                                      8.0), // Space between buttons and output
                              // Output of selected seats inside a bordered box
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black), // Border color
                                  borderRadius: BorderRadius.circular(
                                      8.0), // Rounded corners
                                ),
                                child: Text(
                                  '$selectedSeats',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 18, 86, 117),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,

                                  color: Color.fromARGB(211, 1, 17,
                                      52), // Blue background color for the circle
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.remove,
                                      color: Colors.white), // Icon color
                                  onPressed: () {
                                    if (selectedSeats > 1) {
                                      setState(() {
                                        selectedSeats--;
                                      });
                                    }
                                  },
                                ),
                              ),

                              const SizedBox(
                                  width:
                                      8.0), // Space between output and button
                              // Plus Button
                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(211, 1, 17,
                                      52), // Blue background color for the circle
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.add,
                                      color: Colors.white), // Icon color
                                  onPressed: () {
                                    setState(() {
                                      selectedSeats++;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Base Fare (Previously Total Fare)
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Base Fare',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'GabrielSans',
                            ),
                          ),
                          Text(
                            'PHP $baseFare',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(212, 2, 28, 88),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16.0),

                  // Second Row: Total Fare aligned to the left (Previously Base Fare)
                  Align(
                    alignment: Alignment.centerLeft, // Align to the left
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Fare',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'GabrielSans',
                          ),
                        ),
                        Text(
                          'PHP ${selectedSeats * baseFare}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 18, 86, 117),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16.0),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // First button (Back)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context); // Go back to ticket list
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 20.0,
                          ),
                          backgroundColor: const Color.fromARGB(
                              255, 120, 154, 226), // Button background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(70.0),
                          ),
                        ),
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'GabrielSans',
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),

                      // Second button (Continue)
                      ElevatedButton(
                        onPressed: () {
                          // Close the current bottom sheet (seat selection)
                          Navigator.pop(context);
                          // Navigate to SeatSelectionScreen and pass the selected number of seats
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SeatSelectionScreen(
                                  numberOfSeats: selectedSeats),
                            ),
                          );

                          // Show the confirmation bottom sheet
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30.0,
                            vertical: 20.0,
                          ),
                          backgroundColor: const Color.fromARGB(
                              211, 1, 17, 52), // Button background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(70.0),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontFamily: 'GabrielSans',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

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
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                definition1,
                style: const TextStyle(
                  fontSize: 10,
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
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  definition2,
                  style: const TextStyle(
                      fontSize: 10, color: Color.fromARGB(255, 18, 86, 117)),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
// TODO Implement this library.