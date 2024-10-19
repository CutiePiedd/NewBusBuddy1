<?php
$host = 'localhost';
$user = 'root';
$password = '';
$dbname = 'newdatabase';

$conn = new mysqli($host, $user, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$destination = $_POST['destination'];
$departure_time = $_POST['departure_time'];
$fare = $_POST['fare'];
$origin = $_POST['origin'];
$busNo = $_POST['busNo'];
$serviceClass= $_POST['service'];
$tripHours = $_POST[ 'tripHours'];

$sql = "INSERT INTO tickets (destination, departure_time, fare, origin, busNo, serviceClass, tripHours)
        VALUES ('$destination', '$departure_time', '$fare')";

if ($conn->query($sql) === TRUE) {
    echo json_encode(["success" => true, "message" => "Ticket created successfully"]);
} else {
    echo json_encode(["success" => false, "message" => "Error: " . $conn->error]);
}

$conn->close();
?>
