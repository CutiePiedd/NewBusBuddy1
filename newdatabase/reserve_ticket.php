<?php
// Connection setup
$servername = "localhost";
$username = "root";  // Default for XAMPP
$password = "";      // Default for XAMPP
$dbname = "newdatabase";  // Replace with your database name

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Check for POST request
// Inside reserve_ticket.php
// Assuming you've already established a database connection

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
    $ticket_id = $data['ticket_id'];
    $seats_to_reserve = $data['seats'];
    $user_id = $data['user_id'];  // Add user_id to the incoming request

    // Fetch current available seats
    $query = "SELECT available_seats FROM tickets WHERE id = ?";
    $stmt = $conn->prepare($query);
    $stmt->bind_param("i", $ticket_id);
    $stmt->execute();
    $result = $stmt->get_result();
    $ticket = $result->fetch_assoc();

    if ($ticket) {
        $available_seats = $ticket['available_seats'];

        // Check if enough seats are available
        if ($available_seats >= $seats_to_reserve) {
            // Update available seats
            $new_available_seats = $available_seats - $seats_to_reserve;
            $update_query = "UPDATE tickets SET available_seats = ? WHERE id = ?";
            $update_stmt = $conn->prepare($update_query);
            $update_stmt->bind_param("ii", $new_available_seats, $ticket_id);
            if ($update_stmt->execute()) {
                // Insert reservation into the reservations table
                $insert_query = "INSERT INTO reservationss (user_id, ticket_id, reserved_seats) VALUES (?, ?, ?)";
                $insert_stmt = $conn->prepare($insert_query);
                $insert_stmt->bind_param("iii", $user_id, $ticket_id, $seats_to_reserve);
                if ($insert_stmt->execute()) {
                    echo json_encode(["message" => "Seats reserved successfully", "available_seats" => $new_available_seats]);
                } else {
                    echo json_encode(["error" => "Failed to record reservation"]);
                }
            } else {
                echo json_encode(["error" => "Failed to reserve seats"]);
            }
        } else {
            echo json_encode(["error" => "Not enough available seats"]);
        }
    } else {
        echo json_encode(["error" => "Ticket not found"]);
    }
} else {
    echo json_encode(["error" => "Invalid request method"]);
}

$conn->close();

?>
