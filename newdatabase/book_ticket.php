<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $ticketId = $_POST['ticket_id'] ?? null;
    $userId = $_POST['user_id'] ?? null;
    $seatsAvailed = $_POST['seats_availed'] ?? null;

    // Validate input
    if (is_null($ticketId) || is_null($userId) || is_null($seatsAvailed)) {
        echo "Invalid input";
        exit;
    }

    $conn = new mysqli('localhost', 'root', '', 'newdatabase');

    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Check if there are enough seats
    $seatCheck = "SELECT available_seats FROM tickets WHERE id = ?";
    $stmt = $conn->prepare($seatCheck);
    $stmt->bind_param("i", $ticketId);
    $stmt->execute();
    $seatResult = $stmt->get_result();
    $row = $seatResult->fetch_assoc();

    if ($row && $row['available_seats'] >= $seatsAvailed) {
        // Update the ticket's available seats
        $newSeats = $row['available_seats'] - $seatsAvailed;
        $updateSeats = "UPDATE tickets SET available_seats = ? WHERE id = ?";
        $updateStmt = $conn->prepare($updateSeats);
        $updateStmt->bind_param("ii", $newSeats, $ticketId);
        $updateStmt->execute();

        // Insert into user_tickets table
        $insertUserTicket = "INSERT INTO user_tickets (user_id, ticket_id, seats_availed) VALUES (?, ?, ?)";
        $insertStmt = $conn->prepare($insertUserTicket);
        $insertStmt->bind_param("iii", $userId, $ticketId, $seatsAvailed);
        $insertStmt->execute();

        echo "Seat booked successfully";
    } else {
        echo "Not enough seats available";
    }

    // Close connections
    $stmt->close();
    $updateStmt->close();
    $insertStmt->close();
    $conn->close();
}
?>
