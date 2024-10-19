<?php
// reservation.php
header("Content-Type: application/json");

// Database connection
$servername = "localhost"; // Your database server
$username = "root"; // Your database username
$password = ""; // Your database password
$dbname = "newdatabase"; // Your database name

$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Get POST data
$ticket_id = $_POST['ticket_id'];
$user_id = $_POST['user_id'];
$selected_seats = $_POST['selected_seats'];

// Insert reservation into the database
$sql = "INSERT INTO reservationss (ticket_id, user_id, selected_seats) VALUES (?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("iis", $ticket_id, $user_id, $selected_seats);

if ($stmt->execute()) {
    // Update available seats
    $update_sql = "UPDATE tickets SET available_seats = available_seats - ? WHERE id = ?";
    $update_stmt = $conn->prepare($update_sql);
    $selected_seat_count = count(explode(',', $selected_seats)); // Assuming selected_seats is a comma-separated string
    $update_stmt->bind_param("ii", $selected_seat_count, $ticket_id);
    $update_stmt->execute();

    echo json_encode(["status" => "success", "message" => "Reservation successful!"]);
} else {
    echo json_encode(["status" => "error", "message" => "Reservation failed!"]);
}

$stmt->close();
$conn->close();
?>
