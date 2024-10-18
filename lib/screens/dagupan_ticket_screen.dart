import 'package:flutter/material.dart';
import 'package:newbusbuddy/screens/history_screen.dart';
import 'package:newbusbuddy/screens/intermediary_screen.dart';
import 'package:newbusbuddy/screens/dagupan_seat_selection.dart';
import 'package:newbusbuddy/screens/ticket_receipt_screen.dart';
import 'package:newbusbuddy/widgets/custom_scaffold.dart';
import 'package:mysql1/mysql1.dart'; // MySQL package to fetch tickets from database

class DagupanTicketScreen extends StatefulWidget {
  const DagupanTicketScreen({super.key});

  @override
  _DagupanTicketScreenState createState() => _DagupanTicketScreenState();
}

class _DagupanTicketScreenState extends State<DagupanTicketScreen> {
  List<Map<String, dynamic>> tickets = [];

  @override
  void initState() {
    super.initState();
    _fetchTicketsFromDatabase(); // Fetch tickets from database
  }

  Future<void> _fetchTicketsFromDatabase() async {
    try {
      // Establish database connection
      final conn = await MySqlConnection.connect(ConnectionSettings(
        host:
            'localhost', // Adjust with your actual database connection settings
        port: 3306,
        user: 'root',
        db: 'newdatabase', // Replace with your actual database name
        password: '', // Replace with your database password if required
      ));

      // Query to fetch tickets created by admin
      var results = await conn.query('SELECT * FROM tickets');

      // Store tickets in the tickets list
      setState(() {
        tickets = results.map((row) {
          return {
            'id': row['id'],
            'origin': row['departure_location'],
            'destination': row['destination_location'],
            'busNo': row['bus_no'],
            'serviceClass': row['service_class'],
            'departureTime': row['departure_time'],
            'baseFare': row['base_fare'],
            'tripHours': row['trip_hours'],
          };
        }).toList();
      });

      await conn.close(); // Close the database connection
    } catch (e) {
      print('Error fetching tickets: $e');
    }
  }

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
                fontFamily: 'New',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: tickets.isEmpty
                ? const Center(
                    child:
                        CircularProgressIndicator()) // Show loader while tickets are being fetched
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      final ticket = tickets[index];
                      return _buildTicket(
                        ticket['origin'],
                        ticket['destination'],
                        ticket['busNo'],
                        ticket['serviceClass'],
                        ticket['departureTime'],
                        'Price: PHP ${ticket['baseFare']}',
                        context,
                        ticket['baseFare'],
                        ticket['tripHours'],
                      );
                    },
                  ),
          ),
          const SizedBox(height: 120.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const IntermediaryScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 20.0,
                      ),
                      backgroundColor:
                          const Color.fromARGB(255, 255, 255, 255), // Blue
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(70),
                          bottomLeft: Radius.circular(70),
                        ),
                      ),
                    ),
                    child: const Icon(
                      Icons.home,
                      color: Color.fromARGB(211, 1, 17, 52),
                      size: 25,
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      String origin = 'Dagupan'; // Replace with actual value
                      String busNo = '123'; // Replace with actual value
                      String destination =
                          'Manila'; // Replace with actual value
                      String seatNo = 'A1'; // Replace with actual value
                      double totalFare =
                          500; // Ensure totalFare is calculated properly
                      String date = '2024-10-12'; // Replace with actual value
                      List<int> selectedSeats = []; // Replace with actual value
                      String tripHours = '5 hours'; // Replace with actual value

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HistoryTicketReceiptScreen(
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
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 20.0,
                      ),
                      backgroundColor:
                          const Color.fromARGB(211, 1, 17, 52), // Dark color
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(70),
                          bottomRight: Radius.circular(70),
                        ),
                      ),
                    ),
                    child: const Icon(
                      Icons.receipt,
                      color: Color.fromARGB(210, 255, 255, 255),
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50.0),
        ],
      ),
    );
  }

  Widget _buildTicket(
    String origin,
    String destination,
    String busNo,
    String serviceClass,
    String departureTime,
    String price,
    BuildContext context,
    double baseFare,
    String tripHours,
  ) {
    return GestureDetector(
      onTap: () async {
        final selectedSeats = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DagupanSeatSelection(
              numberOfSeats: 49, // Number of seats available
            ),
          ),
        );

        if (selectedSeats != null) {
          _showConfirmationBottomSheet(
            context,
            origin,
            destination,
            busNo,
            serviceClass,
            departureTime,
            price,
            selectedSeats,
            baseFare,
            tripHours,
          );
        }
      },
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
                const Icon(Icons.arrow_forward, size: 25),
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
            _buildTwoColumnRow('Bus No.', busNo, 'Departure', departureTime),
            const SizedBox(height: 6.0),
            _buildTwoColumnRow(
                'Service Class', serviceClass, 'Trip Hours', tripHours),
            const SizedBox(height: 6.0),
            _buildTwoColumnRow('Terminal', origin, 'Base Fare', price),
            const SizedBox(height: 6.0),
            _buildTwoColumnRow('Destination', destination),
          ],
        ),
      ),
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
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'New',
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                definition1,
                style: const TextStyle(
                  fontSize: 10,
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
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'New',
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  definition2,
                  style: const TextStyle(
                    fontSize: 10,
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

  // Show Confirmation BottomSheet
  void _showConfirmationBottomSheet(
    BuildContext context,
    String origin,
    String destination,
    String busNo,
    String seatNo,
    String date,
    String price,
    List<int> selectedSeats,
    double baseFare,
    String tripHours,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(16.0), bottom: Radius.circular(16.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    origin,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4.0),
                  const Icon(Icons.arrow_forward, size: 25),
                  const SizedBox(width: 4.0),
                  Text(
                    destination,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(color: Colors.black, thickness: 3),
              const SizedBox(height: 16.0),
              _buildTwoColumnRow('Service Class:', 'Regular Aircon'),
              const SizedBox(height: 8.0),
              _buildTwoColumnRow('Bus No.:', busNo),
              const SizedBox(height: 8.0),
              _buildTwoColumnRow('Departure:', '5:00 AM'),
              const SizedBox(height: 8.0),
              _buildTwoColumnRow('Trip Hours:', tripHours),
              const Divider(color: Colors.black, thickness: 3),
              const SizedBox(height: 8.0),
              _buildTwoColumnRow('Selected seats:', '$selectedSeats'),
              const SizedBox(height: 8.0),
              _buildTwoColumnRow(
                  'Amount to pay:', 'PHP ${selectedSeats.length * baseFare}'),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // Close confirmation sheet
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 120, 154, 226), // Back button style
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(70.0)),
                    ),
                    child: const Text(
                      'Back',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'GabrielSans'),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the confirmation sheet
                      _showPaymentBottomSheet(
                          context,
                          origin,
                          destination,
                          busNo,
                          seatNo,
                          date,
                          price,
                          selectedSeats,
                          baseFare,
                          tripHours); // Open payment sheet
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          211, 1, 17, 52), // Proceed button style
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 20.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(70.0)),
                    ),
                    child: const Text(
                      'Proceed',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'GabrielSans'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
    const SizedBox(height: 40.0);
  }

  // Show Payment BottomSheet
  // Show Payment BottomSheet
  void _showPaymentBottomSheet(
    BuildContext context,
    String origin,
    String destination,
    String busNo,
    String seatNo,
    String date,
    String price,
    List<int> selectedSeats,
    double baseFare,
    String tripHours,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: 370.0,
          padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
          margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.0),
              bottom: Radius.circular(16.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Payment Method',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(color: Colors.black, thickness: 3),
              Row(
                children: [
                  Image.asset(
                    'assets/images/gcash.png',
                    height: 80,
                    width: 200,
                  ),
                ],
              ),
              const Divider(color: Colors.black, thickness: 1),
              const SizedBox(height: 60.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(
                          context); // Navigate back to the confirmation bottom sheet
                      _showConfirmationBottomSheet(
                          context,
                          origin,
                          destination,
                          busNo,
                          seatNo,
                          date,
                          price,
                          selectedSeats,
                          baseFare,
                          tripHours);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 120, 154, 226),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 20.0,
                      ),
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
                  ElevatedButton(
                    onPressed: () {
                      double totalFare = selectedSeats.length * baseFare;

                      // Add debugging statement
                      print("Navigating to TicketReceiptScreen");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TicketReceiptScreen(
                            origin: origin,
                            destination: destination,
                            busNo: busNo,
                            seatNo: selectedSeats.join(','),
                            date: date,
                            totalFare: totalFare,
                            selectedSeats: selectedSeats,
                            tripHours: tripHours,
                          ),
                        ),
                      ).then((_) {
                        // Close the payment sheet after navigating
                        Navigator.pop(context);
                      });

                      // Handle payment logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(211, 1, 17, 52),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30.0,
                        vertical: 20.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70.0),
                      ),
                    ),
                    child: const Text(
                      'Pay with Gcash',
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
  }
}
