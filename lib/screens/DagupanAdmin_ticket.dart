import 'package:flutter/material.dart';
import 'package:newbusbuddy/apiTickets_service.dart';
import 'package:newbusbuddy/widgets/custom_scaffold.dart';

class DagupanadminTicket extends StatefulWidget {
  @override
  _DagupanadminTicketState createState() => _DagupanadminTicketState();
}

class _DagupanadminTicketState extends State<DagupanadminTicket> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  TextEditingController busNoController = TextEditingController();
  TextEditingController baseFareController = TextEditingController();

  String selectedServiceClass = 'Regular'; // Default selection
  String selectedDepartureLocation = 'Dagupan';
  String selectedDestinationLocation = 'Cubao';
  String selectedDepartureTime = '06:00 A.M.';
  String selectedTripHours = '2';
  String selectedSeats = '1';
  String ticketStatus = 'active'; // Default status

  // Loading indicator
  bool isLoading = false;

  // Dropdown options
  final List<String> serviceClassOptions = ['Regular', 'Deluxed'];
  final List<String> locationOptions = ['Dagupan', 'Cubao'];
  final List<String> timeOptions = [
    '01:00 A.M.',
    '02:00 A.M.',
    '03:00 A.M.',
    '04:00 A.M.',
    '05:00 A.M.',
    '06:00 A.M.',
    '07:00 A.M.',
    '08:00 A.M.',
    '09:00 A.M.',
    '10:00 A.M.',
    '11:00 A.M.',
    '12:00 P.M.',
    '01:00 P.M.',
    '02:00 P.M.',
    '03:00 P.M.',
    '04:00 P.M.',
    '05:00 P.M.',
    '06:00 P.M.',
    '07:00 P.M.',
    '08:00 P.M.',
    '09:00 P.M.',
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

  // Submit form
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Create ticket data
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

      // Call the API to create a ticket
      try {
        setState(() {
          isLoading = true; // Start loading
        });

        ApiTicketsService apiService =
            ApiTicketsService(); // Create an instance
        await apiService
            .createTicket(ticketData); // Call the createTicket method

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Ticket Created Successfully"),
        ));

        // Optionally, navigate back to the ticket list screen or refresh the list
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to create ticket: $e"),
        ));
      } finally {
        setState(() {
          isLoading = false; // Stop loading
        });
      }
    }
  }

  @override
  void dispose() {
    busNoController.dispose();
    baseFareController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
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
                  items: serviceClassOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Service Class'),
                  validator: (value) =>
                      value == null ? 'Please select a Service Class' : null,
                ),
                DropdownButtonFormField<String>(
                  value: selectedDepartureLocation,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDepartureLocation = newValue!;
                    });
                  },
                  items: locationOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Departure Location'),
                  validator: (value) => value == null
                      ? 'Please select a Departure Location'
                      : null,
                ),
                DropdownButtonFormField<String>(
                  value: selectedDestinationLocation,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDestinationLocation = newValue!;
                    });
                  },
                  items: locationOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration:
                      InputDecoration(labelText: 'Destination Location'),
                  validator: (value) => value == null
                      ? 'Please select a Destination Location'
                      : null,
                ),
                DropdownButtonFormField<String>(
                  value: selectedDepartureTime,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDepartureTime = newValue!;
                    });
                  },
                  items:
                      timeOptions.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Departure Time'),
                  validator: (value) =>
                      value == null ? 'Please select a Departure Time' : null,
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
                  items: tripHourOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Trip Hours'),
                  validator: (value) =>
                      value == null ? 'Please select Trip Hours' : null,
                ),
                DropdownButtonFormField<String>(
                  value: selectedSeats,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedSeats = newValue!;
                    });
                  },
                  items: availableSeats
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Available Seats'),
                  validator: (value) =>
                      value == null ? 'Please select Available Seats' : null,
                ),
                DropdownButtonFormField<String>(
                  value: ticketStatus,
                  onChanged: (String? newValue) {
                    setState(() {
                      ticketStatus = newValue!;
                    });
                  },
                  items: ['active', 'inactive']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(labelText: 'Ticket Status'),
                  validator: (value) =>
                      value == null ? 'Please select Ticket Status' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoading ? null : _submitForm,
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text('Create Ticket'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
