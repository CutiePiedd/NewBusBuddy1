// confirmation_bottom_sheet.dart

import 'package:flutter/material.dart';

void showConfirmationBottomSheet(
    BuildContext context,
    String origin,
    String destination,
    String busNo,
    String seatNo,
    String date,
    String price,
    int selectedSeats,
    double baseFare) {
  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16.0),
            bottom: Radius.circular(16.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Booking Summary',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'GabrielSans',
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Origin: $origin',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Destination: $destination',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Bus No.: $busNo',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Date: $date',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Total Seats: $selectedSeats',
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              'Total Fare: PHP ${selectedSeats * baseFare}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // Additional booking logic can be added here
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 12.0,
                ),
                backgroundColor: const Color.fromARGB(212, 2, 28, 88),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: const Text(
                'Confirm Booking',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontFamily: 'GabrielSans',
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
