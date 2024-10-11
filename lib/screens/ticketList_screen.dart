import 'package:flutter/material.dart';
import 'package:newbusbuddy/apiTickets_service.dart';

class TicketListScreen extends StatefulWidget {
  @override
  _TicketListScreenState createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  late Future<List<dynamic>> futureTickets;

  @override
  void initState() {
    super.initState();
    futureTickets = ApiTicketsService().fetchTickets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Available Tickets')),
      body: FutureBuilder<List<dynamic>>(
        future: futureTickets,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tickets available'));
          } else {
            final tickets = snapshot.data!;
            return ListView.builder(
              itemCount: tickets.length,
              itemBuilder: (context, index) {
                final ticket = tickets[index];
                return ListTile(
                  title: Text(ticket['bus_no']),
                  subtitle:
                      Text('Available Seats: ${ticket['available_seats']}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Call the booking function here
                      ApiTicketsService().bookTicket(ticket['id'], 1);
                    },
                    child: Text('Book Now'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
