<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'DELETE') {
    // Decode the incoming JSON data
    $data = json_decode(file_get_contents("php://input"));

    $ticketId = $data->id;

    // Connect to MySQL
    $conn = new mysqli('localhost', 'root', '', 'newdatabase');

    // Check connection
    if ($conn->connect_error) {
        die(json_encode(["error" => "Connection failed: " . $conn->connect_error]));
    }

    // Prepare and bind the SQL statement to delete a ticket by ID
    $stmt = $conn->prepare("DELETE FROM tickets WHERE id = ?");
    $stmt->bind_param("i", $ticketId);

    if ($stmt->execute()) {
        echo json_encode(["message" => "Ticket deleted successfully"]);
    } else {
        echo json_encode(["error" => "Error deleting ticket: " . $stmt->error]);
    }

    $stmt->close();
    $conn->close();
} else {
    echo json_encode(["error" => "Invalid request method"]);
}
?>
