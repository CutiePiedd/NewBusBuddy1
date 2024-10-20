import 'package:flutter/material.dart';
//import 'package:newbusbuddy/screens/seat_selection.dart';
import 'package:newbusbuddy/widgets/custom_scaffold.dart'; // Ensure correct import path

class UserSeatSelection extends StatefulWidget {
  final int numberOfSeats;

  const UserSeatSelection({
    super.key,
    required this.numberOfSeats,
  });

  @override
  _UserSeatSelectionScreenState createState() =>
      _UserSeatSelectionScreenState();
}

class _UserSeatSelectionScreenState extends State<UserSeatSelection> {
  List<bool> selectedSeats = List.generate(49, (_) => false); // 49 seats total
  int selectedCount = 0; // Track the number of selected seats

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          // Custom header instead of AppBar
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Image.asset(
              'assets/images/logo_white2.png', // Ensure the correct path to your image
              height: 40.0, // Set height for the logo
              fit: BoxFit.contain,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  'Available Seats',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Segoe UI',
                    fontSize: 40,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                // Building the first 11 rows (each with 4 seats)
                for (int i = 0; i < 11; i++) // 11 rows with 4 seats each
                  Container(
                    margin: const EdgeInsets.only(
                        bottom: 10.0), // Bottom margin for each row
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildSeat(i * 4, 'A'),
                        buildSeat(i * 4 + 1, 'B'),
                        const SizedBox(
                            width: 20), // Spacing between left and right seats
                        buildSeat(i * 4 + 2, 'C'),
                        buildSeat(i * 4 + 3, 'D'),
                      ],
                    ),
                  ),
                // Building the last row with 5 seats
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int j = 0; j < 5; j++) buildSeat(44 + j, 'E'),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Go back without selecting
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 20.0,
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 246, 204, 35),
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      fontFamily: 'GabrielSans',
                      fontSize: 18,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: selectedCount > 0
                      ? () {
                          // Filter selected seats and return only the selected ones
                          List<int> selectedSeatIndices = [];
                          for (int i = 0; i < selectedSeats.length; i++) {
                            if (selectedSeats[i]) {
                              selectedSeatIndices
                                  .add(i + 1); // Store seat number
                            }
                          }

                          Navigator.pop(context, {
                            'selectedSeats': selectedSeatIndices,
                            'selectedCount': selectedCount,
                          });
                          // Pass selected seats
                        }
                      : null, // Disable button if no seats are selected
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      vertical: 20.0,
                    ),
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 245, 126, 15),
                  ),
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      fontFamily: 'GabrielSans',
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSeat(int index, String rowLetter) {
    bool isAvailable =
        true; // Replace with your condition for seat availability

    return GestureDetector(
      onTap: isAvailable
          ? () {
              setState(() {
                if (selectedSeats[index]) {
                  selectedSeats[index] = false;
                  selectedCount--;
                } else if (selectedCount < widget.numberOfSeats) {
                  selectedSeats[index] = true;
                  selectedCount++;
                }
              });
            }
          // ignore: dead_code
          : null,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: selectedSeats[index]
              ? const Color.fromARGB(255, 55, 255, 5) // Selected seat color
              : Colors.white, // Available seat color
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        width: 50,
        height: 50,
        child: Center(
          child: Text(
            '$rowLetter ${index + 1}',
            style: const TextStyle(
              color: Color.fromRGBO(0, 0, 0, 1),
            ),
          ),
        ),
      ),
    );
  }
}
