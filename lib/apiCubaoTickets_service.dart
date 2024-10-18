import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiCubaoTicketsService {
  final String apiUrl =
      "http://localhost/newdatabase"; // Change to your actual URL

  // Function to create a new Cubao ticket
  Future<void> createCubaoTicket(Map<String, dynamic> ticketData) async {
    final response = await http.post(
      Uri.parse('$apiUrl/create_cubao_ticket.php'), // Update the endpoint
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(ticketData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create Cubao ticket');
    }
  }

  // Function to fetch Cubao tickets from the server
  Future<List<dynamic>> fetchCubaoTickets() async {
    final response = await http.get(
      Uri.parse('$apiUrl/fetch_cubao_tickets.php'), // Update the endpoint
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load Cubao tickets');
    }
  }

  Future<void> deleteCubaoTicket(int id) async {
    final response = await http.delete(
      Uri.parse('http://localhost/newdatabase/delete_cubao_tickets.php'),
      body: jsonEncode({"id": id}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete ticket');
    }
  }

  // Function to reserve a Cubao ticket
  Future<void> reserveSeats(
      int ticketId, int userId, String selectedSeats) async {
    final response = await http.post(
      Uri.parse('http://localhost/newdatabase/reservation.php'),
      body: {
        'ticket_id': ticketId.toString(),
        'user_id': userId.toString(),
        'selected_seats': selectedSeats,
      },
    );

    if (response.statusCode == 200) {
      // Handle successful reservation
      print('Reservation successful: ${response.body}');
    } else {
      // Handle error
      print('Error: ${response.body}');
    }
  }
}
