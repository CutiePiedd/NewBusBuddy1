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
      Uri.parse('$apiUrl/get_tickets.php'),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load tickets');
    }
  }

  Future<void> deleteTicket(int id) async {
    // Update the URL to point to your backend PHP script
    final response = await http.delete(
      Uri.parse(
          'http://localhost/newdatabase/delete_ticket.php?id=$id'), // Correct the URL format
    );

    print('Delete response status: ${response.statusCode}'); // Debugging line

    if (response.statusCode == 200) {
      // Deletion successful
      print('Ticket deleted successfully'); // Optional confirmation
      return;
    } else {
      print('Failed to delete ticket: ${response.body}'); // Debugging line
      throw Exception('Failed to delete the ticket');
    }
  }

  // Function to reserve a ticket
  Future<void> reserveTicket(int ticketId, int seats, int userId) async {
    final response = await http.post(
      Uri.parse('$apiUrl/reserve_ticket.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "ticket_id": ticketId,
        "seats": seats,
        "user_id": userId
      }), // Include user_id
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error')) {
        throw Exception(responseBody['error']);
      } else {
        print(responseBody['message']);
      }
    } else {
      throw Exception('Failed to reserve ticket');
    }
  }
}
