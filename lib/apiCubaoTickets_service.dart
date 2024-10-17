import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiCubaoTicketsService {
  final String apiUrl =
      "http://localhost/newdatabase"; // Change to your actual URL

  // Function to create a new Cubao ticket
  Future<void> createCubaoTicket(Map<String, dynamic> ticketData) async {
    final response = await http.post(
      Uri.parse('$apiUrl/create_tickets.php'), // Update the endpoint
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
      Uri.parse('$apiUrl/get_cubao_tickets.php'), // Update the endpoint
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
      Uri.parse(
          'http://localhost/newdatabase/delete_cubao_ticket.php?id=$id'), // Correct the URL format
    );

    print('Delete response status: ${response.statusCode}'); // Debugging line

    if (response.statusCode == 200) {
      print('Cubao ticket deleted successfully'); // Optional confirmation
      return;
    } else {
      print(
          'Failed to delete Cubao ticket: ${response.body}'); // Debugging line
      throw Exception('Failed to delete the Cubao ticket');
    }
  }

  // Function to reserve a Cubao ticket
  Future<void> reserveCubaoTicket(int ticketId, int seats, int userId) async {
    final response = await http.post(
      Uri.parse('$apiUrl/reserve_cubao_ticket.php'), // Update the endpoint
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(
          {"ticket_id": ticketId, "seats": seats, "user_id": userId}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody.containsKey('error')) {
        throw Exception(responseBody['error']);
      } else {
        print(responseBody['message']);
      }
    } else {
      throw Exception('Failed to reserve Cubao ticket');
    }
  }
}
