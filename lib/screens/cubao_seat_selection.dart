import 'package:flutter/material.dart';
//import 'package:newbusbuddy/screens/seat_selection.dart';
import 'package:newbusbuddy/widgets/custom_scaffold.dart'; // Ensure correct import path

class CubaoSeatSelectionScreen extends StatefulWidget {
  final int numberOfSeats; // The number of seats the user can select

  const CubaoSeatSelectionScreen({super.key, required this.numberOfSeats});

  @override
  _CubaoSeatSelectionScreenState createState() =>
      _CubaoSeatSelectionScreenState();
}

class _CubaoSeatSelectionScreenState extends State<CubaoSeatSelectionScreen> {
  // Create a list for seat selection, with 49 seats
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedSeats[i * 4]) {
                                selectedSeats[i * 4] = false;
                                selectedCount--;
                              } else if (selectedCount < widget.numberOfSeats) {
                                selectedSeats[i * 4] = true;
                                selectedCount++;
                              }
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              color: selectedSeats[i * 4]
                                  ? const Color.fromARGB(211, 1, 17, 52)
                                  : Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                            ),
                            width: 60,
                            height: 60,
                            child: Center(
                              child: Text(
                                'A ${i * 4 + 1}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedSeats[i * 4 + 1]) {
                                selectedSeats[i * 4 + 1] = false;
                                selectedCount--;
                              } else if (selectedCount < widget.numberOfSeats) {
                                selectedSeats[i * 4 + 1] = true;
                                selectedCount++;
                              }
                            });
                          },
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: selectedSeats[i * 4 + 1]
                                  ? const Color.fromARGB(211, 1, 17, 52)
                                  : Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                            ),
                            width: 60,
                            height: 60,
                            child: Center(
                              child: Text(
                                'B ${i * 4 + 2}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                            width: 20), // Spacing between left and right seats
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedSeats[i * 4 + 2]) {
                                selectedSeats[i * 4 + 2] = false;
                                selectedCount--;
                              } else if (selectedCount < widget.numberOfSeats) {
                                selectedSeats[i * 4 + 2] = true;
                                selectedCount++;
                              }
                            });
                          },
                          child: Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: selectedSeats[i * 4 + 2]
                                  ? const Color.fromARGB(211, 1, 17, 52)
                                  : Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                            ),
                            width: 60,
                            height: 60,
                            child: Center(
                              child: Text(
                                'C ${i * 4 + 3}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedSeats[i * 4 + 3]) {
                                selectedSeats[i * 4 + 3] = false;
                                selectedCount--;
                              } else if (selectedCount < widget.numberOfSeats) {
                                selectedSeats[i * 4 + 3] = true;
                                selectedCount++;
                              }
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              color: selectedSeats[i * 4 + 3]
                                  ? const Color.fromARGB(211, 1, 17, 52)
                                  : Colors.white,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15.0),
                                topRight: Radius.circular(15.0),
                              ),
                            ),
                            width: 60,
                            height: 60,
                            child: Center(
                              child: Text(
                                'D ${i * 4 + 4}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                // Building the last row with 5 seats
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int j = 0; j < 5; j++)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (selectedSeats[44 + j]) {
                              selectedSeats[44 + j] = false;
                              selectedCount--;
                            } else if (selectedCount < widget.numberOfSeats) {
                              selectedSeats[44 + j] = true;
                              selectedCount++;
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          decoration: BoxDecoration(
                            color: selectedSeats[44 + j]
                                ? const Color.fromARGB(211, 1, 17, 52)
                                : Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15.0),
                              topRight: Radius.circular(15.0),
                            ),
                          ),
                          width: 60,
                          height: 60,
                          child: Center(
                            child: Text(
                              'E ${44 + j + 1}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
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
                    backgroundColor:
                        const Color.fromARGB(255, 120, 154, 226), // Text color
                  ),
                  child: const Text(
                    'Back',
                    style: TextStyle(
                      fontFamily: 'GabrielSans', // Change to your font family
                      fontSize: 18, // Change to your desired font size
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

                          Navigator.pop(context,
                              selectedSeatIndices); // Pass selected seats
                        }
                      : null, // Disable button if no seats are selected
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 20.0),
                    foregroundColor: Colors.white,
                    backgroundColor:
                        const Color.fromARGB(211, 1, 17, 52), // Text color
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
}
