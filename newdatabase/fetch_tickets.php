<?php
$conn = new mysqli('localhost', 'root', '', 'newdatabase');

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch active tickets
$sql = "SELECT * FROM tickets WHERE status = 'active'";
$result = $conn->query($sql);

$tickets = array();
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $tickets[] = $row;
    }
}
echo json_encode($tickets);

$conn->close();
?>
