<?php
// Include database connection
require_once 'db_connection.php'; // Update this path to your actual database connection file

// Set content-type to JSON
header('Content-Type: application/json');

// Get POST data
$data = json_decode(file_get_contents('php://input'), true);

if (isset($data['ticket_id']) && isset($data['user_id']) && isset($data['selected_seats'])) {
    $ticket_id = $data['ticket_id'];
    $user_id = $data['user_id'];
    $selected_seats = $data['selected_seats']; // Expecting a string like "1,2,3"

    // 1. Retrieve the current available seats from the tickets table
    $query = "SELECT available_seats FROM tickets WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $ticket_id);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $ticket = $result->fetch_assoc();
        $available_seats = explode(',', $ticket['available_seats']); // Assuming available_seats is stored as a CSV

        // 2. Check if the selected seats are still available
        $selected_seat_array = explode(',', $selected_seats);
        $seats_available = true;

        foreach ($selected_seat_array as $seat) {
            if (!in_array($seat, $available_seats)) {
                $seats_available = false;
                break;
            }
        }

        if ($seats_available) {
            // 3. Remove the selected seats from the available_seats array
            $remaining_seats = array_diff($available_seats, $selected_seat_array);

            // 4. Update the ticket in the database with the new available seats
            $remaining_seats_str = implode(',', $remaining_seats);
            $update_query = "UPDATE tickets SET available_seats = ? WHERE id = ?";
            $update_stmt = $conn->prepare($update_query);
            $update_stmt->bind_param("si", $remaining_seats_str, $ticket_id);
            $update_stmt->execute();

            // 5. Insert the reservation into the reservations table
            $insert_query = "INSERT INTO reservations (ticket_id, user_id, selected_seats) VALUES (?, ?, ?)";
            $insert_stmt = $conn->prepare($insert_query);
            $insert_stmt->bind_param("iis", $ticket_id, $user_id, $selected_seats);
            $insert_stmt->execute();

            // 6. Return success response
            echo json_encode([
                'success' => true,
                'message' => 'Ticket reserved successfully!'
            ]);
        } else {
            // Return an error if selected seats are no longer available
            echo json_encode([
                'success' => false,
                'message' => 'Selected seats are no longer available.'
            ]);
        }
    } else {
        echo json_encode([
            'success' => false,
            'message' => 'Ticket not found.'
        ]);
    }
} else {
    echo json_encode([
        'success' => false,
        'message' => 'Invalid request data.'
    ]);
}

$conn->close();
?>
