import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiTicketsService {
  final String apiUrl =
      "http://localhost/newdatabase"; // Change to your actual URL

  // Function to create a new ticket
  Future<void> createTicket(Map<String, dynamic> ticketData) async {
    final response = await http.post(
      Uri.parse('$apiUrl/create_ticket.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(ticketData),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to create ticket');
    }
  }

  // Function to fetch tickets from the server
  Future<List<dynamic>> fetchTickets() async {
    final response = await http.get(
      Uri.parse('$apiUrl/fetch_tickets.php'),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load tickets');
    }
  }

  Future<void> deleteTicket(int id) async {
    final response = await http.delete(
      Uri.parse('http://localhost/newdatabase/delete_ticket.php'),
      body: jsonEncode({"id": id}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete ticket');
    }
  }

  // Function to reserve a ticket

  Future<void> makeReservation(
      int ticketId, int userId, String selectedSeats) async {
    final response = await http.post(
      Uri.parse(
          'http://localhost/newdatabase/reservationw.php'), // Change to your server URL
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'ticket_id': ticketId.toString(),
        'user_id': userId.toString(),
        'selected_seats': selectedSeats,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'success') {
        // Handle successful reservation
        print(data['message']);
        // Update UI or notify the user
      } else {
        // Handle reservation error
        print(data['message']);
      }
    } else {
      print('Failed to make reservation: ${response.statusCode}');
    }
  }
}
