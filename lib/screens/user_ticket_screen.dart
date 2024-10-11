import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserTicketScreen extends StatefulWidget {
  const UserTicketScreen({super.key});

  @override
  _UserTicketScreenState createState() => _UserTicketScreenState();
}

class _UserTicketScreenState extends State<UserTicketScreen> {
  List<dynamic> tickets = [];

  @override
  void initState() {
    super.initState();
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    final response =
        await http.get(Uri.parse('http://your-server-url/get_tickets.php'));
    if (response.statusCode == 200) {
      setState(() {
        tickets = json.decode(response.body);
      });
    } else {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Tickets'),
      ),
      body: ListView.builder(
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tickets[index]['destination']),
            subtitle: Text(
                'Departure Time: ${tickets[index]['departure_time']}\nPrice: \$${tickets[index]['price']}'),
          );
        },
      ),
    );
  }
}
