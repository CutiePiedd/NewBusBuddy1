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

  Future<void> reserveSeats(
      int ticketId, List<int> selectedSeats, int userId) async {
    final String url =
        'http://localhost/newdatabase/store_reservation.php'; // Replace with your actual backend URL
    print('Ticket ID: $ticketId'); // Debugging - check if this value is correct

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          "ticket_id": ticketId,
          "selected_seats": selectedSeats,
          "user_id": userId,
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['error'] == null) {
          print("Reservation successful");
          // Here you can navigate to the Ticket Receipt Screen
        } else {
          print("Error: ${responseBody['error']}");
        }
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<List<int>> fetchAvailableSeats(int ticketId) async {
    final String url =
        'http://localhost/newdatabase/fetch_ticket_availability.php?ticket_id=$ticketId'; // Replace with your actual server IP address and path

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['available_seats'] != null) {
          List<int> availableSeats = (responseBody['available_seats'] as List)
              .map((seat) => int.parse(seat))
              .toList();
          return availableSeats;
        } else {
          throw Exception(responseBody['error']);
        }
      } else {
        throw Exception('Failed to load available seats');
      }
    } catch (e) {
      throw Exception('Failed to fetch available seats: $e');
    }
  }
}
