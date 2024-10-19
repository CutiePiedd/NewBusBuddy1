// create_ticket.php
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


if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $bus_no = $_POST['bus_no'];
    $service_class = $_POST['service_class'];
    $departure_location = $_POST['departure_location'];
    $destination_location = $_POST['destination_location'];
    $departure_time = $_POST['departure_time'];
    $base_fare = $_POST['base_fare'];
    $trip_hours = $_POST['trip_hours'];
    $available_seats = $_POST['available_seats'];
    $ticket_status = $_POST['ticket_status'];

    $query = "INSERT INTO ticket (bus_no, service_class, departure_location, destination_location, departure_time, base_fare, trip_hours, available_seats, ticket_status) 
              VALUES ('$bus_no', '$service_class', '$departure_location', '$destination_location', '$departure_time', '$base_fare', '$trip_hours', '$available_seats', '$ticket_status')";
    
    if (mysqli_query($conn, $query)) {
        echo json_encode(['status' => 'success', 'message' => 'Ticket Created Successfully']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Failed to create ticket']);
    }
}
}
?>
