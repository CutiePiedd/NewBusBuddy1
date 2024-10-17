import 'package:flutter/material.dart';
import 'package:newbusbuddy/apiCubaoTickets_service.dart';
//import 'package:newbusbuddy/apiTickets_service.dart';
import 'package:newbusbuddy/widgets/custom_scaffold.dart';

class CubaoAdminTicket extends StatefulWidget {
  @override
  _CubaoAdminTicketState createState() => _CubaoAdminTicketState();
}

class _CubaoAdminTicketState extends State<CubaoAdminTicket> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController busNoController = TextEditingController();
  TextEditingController baseFareController = TextEditingController();

  String selectedServiceClass = 'Regular';
  String selectedDepartureLocation = 'Dagupan';
  String selectedDestinationLocation = 'Cubao';
  String selectedDepartureTime = '6:00 A.M.';
  String selectedTripHours = '2';
  String selectedSeats = '1';
  String ticketStatus = 'active';

  bool isLoading = false;
  List<dynamic> cubaotickets = [];

  final List<String> serviceClassOptions = ['Regular', 'Deluxed'];
  final List<String> locationOptions = ['Dagupan', 'Cubao'];
  final List<String> timeOptions = [
    '1:00 A.M.',
    '2:00 A.M.',
    '3:00 A.M.',
    '4:00 A.M.',
    '5:00 A.M.',
    '6:00 A.M.',
    '7:00 A.M.',
    '8:00 A.M.',
    '9:00 A.M.',
    '10:00 A.M.',
    '11:00 A.M.',
    '12:00 P.M.',
    '1:00 P.M.',
    '2:00 P.M.',
    '3:00 P.M.',
    '4:00 P.M.',
    '5:00 P.M.',
    '6:00 P.M.',
    '7:00 P.M.',
    '8:00 P.M.',
    '9:00 P.M.',
    '10:00 P.M.',
    '11:00 P.M.',
    '12:00 A.M.'
  ];
  final List<String> tripHourOptions = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11'
  ];
  final List<String> availableSeats =
      List<String>.generate(49, (index) => (index + 1).toString());

  ApiCubaoTicketsService apiService = ApiCubaoTicketsService();

  @override
  void initState() {
    super.initState();
    _fetchCubaoTickets(); // Fetch tickets when the screen loads
  }

  // Fetch tickets from backend
  void _fetchCubaoTickets() async {
    try {
      setState(() {
        isLoading = true;
      });
      cubaotickets = await apiService.fetchCubaoTickets();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to load tickets: $e"),
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Submit form to create a ticket
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> ticketData = {
        'bus_no': busNoController.text,
        'service_class': selectedServiceClass,
        'departure_location': selectedDepartureLocation,
        'destination_location': selectedDestinationLocation,
        'departure_time': selectedDepartureTime,
        'base_fare': baseFareController.text,
        'trip_hours': selectedTripHours,
        'available_seats': selectedSeats,
        'ticket_status': ticketStatus,
      };

      try {
        setState(() {
          isLoading = true;
        });
        await apiService.createCubaoTicket(ticketData);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Ticket Created Successfully"),
        ));
        _fetchCubaoTickets(); // Refresh the list after creating a ticket
        _clearForm(); // Clear the form after submission
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to create ticket: $e"),
        ));
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Clear form fields
  void _clearForm() {
    busNoController.clear();
    baseFareController.clear();
    selectedServiceClass = 'Regular';
    selectedDepartureLocation = 'Dagupan';
    selectedDestinationLocation = 'Cubao';
    selectedDepartureTime = '6:00 A.M.';
    selectedTripHours = '2';
    selectedSeats = '1';
    ticketStatus = 'active';
  }

  // Delete a ticket
  void _deleteTicket(int id) async {
    try {
      await apiService.deleteCubaoTicket(id);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Ticket Deleted Successfully"),
      ));
      _fetchCubaoTickets(); // Refresh the list after deletion
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to delete ticket: $e"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Ticket creation form
            Form(
              key: _formKey,
              child: Expanded(
                child: ListView(
                  children: [
                    TextFormField(
                      controller: busNoController,
                      decoration: InputDecoration(labelText: 'Bus No.'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Bus No.';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedServiceClass,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedServiceClass = newValue!;
                        });
                      },
                      items: serviceClassOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(labelText: 'Service Class'),
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedDepartureLocation,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDepartureLocation = newValue!;
                        });
                      },
                      items: locationOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration:
                          InputDecoration(labelText: 'Departure Location'),
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedDestinationLocation,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDestinationLocation = newValue!;
                        });
                      },
                      items: locationOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration:
                          InputDecoration(labelText: 'Destination Location'),
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedDepartureTime,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDepartureTime = newValue!;
                        });
                      },
                      items: timeOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(labelText: 'Departure Time'),
                    ),
                    TextFormField(
                      controller: baseFareController,
                      decoration: InputDecoration(labelText: 'Base Fare'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Base Fare';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedTripHours,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedTripHours = newValue!;
                        });
                      },
                      items: tripHourOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(labelText: 'Trip Hours'),
                    ),
                    DropdownButtonFormField<String>(
                      value: selectedSeats,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSeats = newValue!;
                        });
                      },
                      items: availableSeats.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(labelText: 'Available Seats'),
                    ),
                    DropdownButtonFormField<String>(
                      value: ticketStatus,
                      onChanged: (String? newValue) {
                        setState(() {
                          ticketStatus = newValue!;
                        });
                      },
                      items: ['active', 'inactive'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(labelText: 'Ticket Status'),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Create Ticket'),
                    ),
                  ],
                ),
              ),
            ),

            // Ticket List Display
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: cubaotickets.length,
                      itemBuilder: (context, index) {
                        var cubaoticket = cubaotickets[index]; // Corrected line

                        return ListTile(
                          title: Text(
                              'Bus No: ${cubaoticket['bus_no']} - ${cubaoticket['service_class']}'),
                          subtitle: Text(
                              'From ${cubaoticket['departure_location']} to ${cubaoticket['destination_location']} at ${cubaoticket['departure_time']}'),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              print(
                                  'Deleting ticket with id: ${cubaoticket['id']}');
                              _deleteTicket(cubaoticket['id']);
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
