import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiTicketsService {
  // Use the correct URL where your PHP files are located
  static const String baseUrl = 'http://localhost/newdatabase';

  // Create Ticket
  Future<void> createTicket(Map<String, dynamic> ticketData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create_ticket.php'),
      headers: {
        'Content-Type': 'application/json', // Specify the content type
      },
      body: json.encode(ticketData), // Encode ticketData as JSON
    );

    if (response.statusCode == 200) {
      print('Ticket created: ${response.body}');
    } else {
      throw Exception('Failed to create ticket: ${response.body}');
    }
  }

  // Fetch Tickets
  Future<List<dynamic>> fetchTickets() async {
    final response = await http.get(Uri.parse('$baseUrl/fetch_tickets.php'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load tickets: ${response.body}');
    }
  }

  // Book Ticket
  Future<void> bookTicket(int ticketId, int seats) async {
    final response = await http.post(
      Uri.parse('$baseUrl/book_ticket.php'),
      headers: {
        'Content-Type': 'application/json', // Specify the content type
      },
      body: json.encode({
        'ticket_id': ticketId,
        'seats': seats,
      }), // Encode as JSON
    );

    if (response.statusCode == 200) {
      print('Booking response: ${response.body}');
    } else {
      throw Exception('Failed to book ticket: ${response.body}');
    }
  }
}
