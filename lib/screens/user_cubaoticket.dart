import 'package:flutter/material.dart';
import 'package:newbusbuddy/apiCubaoTickets_service.dart';
//import 'package:newbusbuddy/apiTickets_service.dart';
import 'package:newbusbuddy/screens/history_screen.dart';
import 'package:newbusbuddy/screens/intermediary_screen.dart';
//import 'package:newbusbuddy/screens/paymongo.dart';
import 'package:newbusbuddy/screens/ticket_receipt_screen.dart';
import 'package:newbusbuddy/screens/user_seat_selection.dart';
import 'package:newbusbuddy/widgets/custom_scaffold.dart';
import 'package:intl/intl.dart';

class UserCubaoTicketsScreen extends StatefulWidget {
  @override
  _UserCubaoTicketsScreenState createState() => _UserCubaoTicketsScreenState();
}

class _UserCubaoTicketsScreenState extends State<UserCubaoTicketsScreen> {
  bool isLoading = true;
  List<dynamic> tickets = []; // To store the fetched tickets
  String errorMessage = '';
  late final String origin;
  late final String destination;
  late final String busNo;
  late final String seatNo;
  late final String date;
  late final double totalFare;
  late final List<int> selectedSeats;
  late final String tripHours;

  @override
  void initState() {
    super.initState();
    _fetchCubaoTickets();
  }

  // Fetch tickets from backend
  Future<void> _fetchCubaoTickets() async {
    try {
      ApiCubaoTicketsService apiService = ApiCubaoTicketsService();
      List<dynamic> fetchedCubaoTickets = await apiService.fetchCubaoTickets();

      setState(() {
        tickets = fetchedCubaoTickets;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        errorMessage = 'Failed to load tickets: $error';
        isLoading = false;
      });
    }
  }

  // Function to format time
  String formatTime(String timeString) {
    DateTime dateTime = DateFormat("HH:mm:ss").parse(timeString);
    return DateFormat("hh:mm a").format(dateTime); // Converts to "hh:mm AM/PM"
  }

  // Mimicking the layout of _buildTicket
  Widget _buildTicket(Map<String, dynamic> ticket) {
    return GestureDetector(
      onTap: () async {
        // Navigate to UserSeatSelection and await the result
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserSeatSelection(numberOfSeats: 49),
          ),
        );

        // Check if result is not null
        if (result != null) {
          _showConfirmationSheet(ticket, result);
        }
      },
      child: Container(
        height: 180.0,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(255, 5, 2, 54).withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  ticket['departure_location'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Segoe UI',
                  ),
                ),
                const SizedBox(width: 4.0),
                const Icon(
                  Icons.arrow_forward,
                  size: 20,
                ),
                const SizedBox(width: 4.0),
                Text(
                  ticket['destination_location'],
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Segoe UI',
                  ),
                ),
              ],
            ),
            const Divider(
              color: Colors.black,
              thickness: 3,
            ),
            const SizedBox(height: 6.0),
            _buildTwoColumnRow(
              'Bus No.',
              ticket['bus_no'],
              'Trip Hours',
              ticket['trip_hours'],
            ),
            const SizedBox(height: 6.0),
            _buildTwoColumnRow(
              'Service Class',
              ticket['service_class'],
              'Base Fare',
              ticket['base_fare'].toString(),
            ),
            const SizedBox(height: 6.0),
            _buildTwoColumnRow(
              'Departure',
              formatTime(ticket['departure_time']),
            ),
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
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'New',
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                definition1,
                style: const TextStyle(
                  fontSize: 11,
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
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'New',
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  definition2,
                  style: const TextStyle(
                    fontSize: 11,
                    fontFamily: 'New',
                    color: Color.fromARGB(255, 18, 86, 117),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // Function to show confirmation sheet
  void _showConfirmationSheet(
      Map<String, dynamic> ticket, Map<String, dynamic> result) {
    int selectedCount = result['selectedCount'];
    List<int> selectedSeats = result['selectedSeats'];
    double baseFare = double.parse(ticket['base_fare'].toString());
    double totalFare = baseFare * selectedCount;

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
                    ticket['departure_location'],
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 4.0),
                  const Icon(Icons.arrow_forward, size: 25),
                  const SizedBox(width: 4.0),
                  Text(
                    ticket['destination_location'],
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const Divider(color: Colors.black, thickness: 3),
              const SizedBox(height: 16.0),
              _buildTwoColumnRow('Service Class:', ticket['service_class']),
              const SizedBox(height: 8.0),
              _buildTwoColumnRow('Bus No.:', ticket['bus_no']),
              const SizedBox(height: 8.0),
              _buildTwoColumnRow(
                  'Departure:', formatTime(ticket['departure_time'])),
              const SizedBox(height: 8.0),
              _buildTwoColumnRow('Trip Hours:', ticket['trip_hours']),
              const Divider(color: Colors.black, thickness: 3),
              const SizedBox(height: 8.0),
              _buildTwoColumnRow('Selected Seats:', selectedSeats.join(', ')),
              const SizedBox(height: 8.0),
              _buildTwoColumnRow(
                  'Amount to Pay:', 'PHP ${totalFare.toStringAsFixed(2)}'),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close confirmation sheet
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
                      // Here you can call the next function for payment, if needed
                      // _showPaymentBottomSheet(context, ...);
                      _showPaymentSheet(totalFare, ticket, result);
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
  }

  void _showPaymentSheet(double totalFare, Map<String, dynamic> ticket,
      Map<String, dynamic> result) {
    setState(() {
      origin = ticket['departure_location'];
      busNo = ticket['bus_no'];
      destination = ticket['destination_location'];
      seatNo = result['selectedSeats'].join(', ');
      date = DateFormat('yyyy-MM-dd').format(DateTime.now());
      this.totalFare = totalFare;
      selectedSeats = result['selectedSeats'];
      tripHours = ticket['trip_hours'];
    });

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
              Center(
                child: Text(
                  'Payment Details',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(color: Colors.black, thickness: 3),
              const SizedBox(height: 16.0),
              // Add GCash logo
              Center(
                child: Image.asset(
                  'assets/images/gcash.png',
                  height: 50,
                ),
              ),
              const SizedBox(height: 16.0),
              _buildTwoColumnRow(
                  'Amount to Pay:', 'PHP ${totalFare.toStringAsFixed(2)}'),
              const SizedBox(height: 8.0),
              _buildTwoColumnRow('Payment Method:', 'GCash'),
              const SizedBox(height: 8.0),
              const Divider(color: Colors.black, thickness: 3),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close payment sheet
                      _showConfirmationSheet(ticket, result);
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
                    onPressed: () async {
                      // Get userId (you might need to replace this with your actual logic)
                      // Replace with actual user ID

                      // Reserve the tickets before proceeding

                      // Proceed with the payment
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
                      'Proceed to Pay',
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
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Image.asset(
              'assets/images/logo_white2.png',
              height: 50,
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                    ? Center(child: Text(errorMessage))
                    : ListView.builder(
                        itemCount: tickets.length,
                        itemBuilder: (context, index) {
                          final ticket = tickets[index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: _buildTicket(ticket),
                          );
                        },
                      ),
          ),
          const SizedBox(height: 50.0),
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
                                  const IntermediaryScreen())); // Replace with your actual route
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
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.home,
                          color: Color.fromARGB(211, 1, 17, 52),
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
                      backgroundColor:
                          const Color.fromARGB(211, 1, 17, 52), // Dark color
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
                          color: Color.fromARGB(210, 255, 255, 255),
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
    );
  }
}
