// available_seats.php
<?php
header("Content-Type: application/json");

// Database connection
// (Same connection code as before)

$ticket_id = $_GET['ticket_id'];
$sql = "SELECT available_seats FROM tickets WHERE id = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $ticket_id);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    echo json_encode(["available_seats" => $row['available_seats']]);
} else {
    echo json_encode(["available_seats" => 0]);
}

$stmt->close();
$conn->close();
?>
