<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $ticketId = $_POST['ticket_id'];
    $userId = $_POST['user_id'];
    $seatsAvailed = $_POST['seats_availed'];

    $conn = new mysqli('localhost', 'root', '', 'newdatabase');

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Check if there are enough seats
    $seatCheck = "SELECT available_seats FROM tickets WHERE id = $ticketId";
    $seatResult = $conn->query($seatCheck);
    $row = $seatResult->fetch_assoc();

    if ($row['available_seats'] >= $seatsAvailed) {
        // Update the ticket's available seats
        $newSeats = $row['available_seats'] - $seatsAvailed;
        $updateSeats = "UPDATE tickets SET available_seats = $newSeats WHERE id = $ticketId";
        $conn->query($updateSeats);

        // Insert into user_tickets table
        $insertUserTicket = "INSERT INTO user_tickets (user_id, ticket_id, seats_availed) VALUES ($userId, $ticketId, $seatsAvailed)";
        $conn->query($insertUserTicket);

        echo "Seat booked successfully";
    } else {
        echo "Not enough seats available";
    }

    $conn->close();
}
?>
