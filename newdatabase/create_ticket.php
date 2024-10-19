<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Decode the incoming JSON data
    $data = json_decode(file_get_contents("php://input"));

    $busNo = $data->bus_no;
    $serviceClass = $data->service_class;
    $departureLocation = $data->departure_location;
    $destinationLocation = $data->destination_location;
    $departureTime = $data->departure_time;
    $baseFare = $data->base_fare;
    $tripHours = $data->trip_hours;
    $availableSeats = $data->available_seats;
    $status = $data->ticket_status;

    // Connect to MySQL
    $conn = new mysqli('localhost', 'root', '', 'newdatabase');

    // Check connection
    if ($conn->connect_error) {
        die(json_encode(["error" => "Connection failed: " . $conn->connect_error]));
    }

    // Prepare and bind the SQL statement
    $stmt = $conn->prepare("INSERT INTO tickets (bus_no, service_class, departure_location, destination_location, departure_time, base_fare, trip_hours, available_seats, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("sssssddss", $busNo, $serviceClass, $departureLocation, $destinationLocation, $departureTime, $baseFare, $tripHours, $availableSeats, $status);

    // Execute the statement
    if ($stmt->execute()) {
        echo json_encode(["message" => "New ticket created successfully"]);
    } else {
        echo json_encode(["error" => "Error: " . $stmt->error]);
    }

    // Close connections
    $stmt->close();
    $conn->close();
} else {
    echo json_encode(["error" => "Invalid request method"]);
}
?>
