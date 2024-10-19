// fetch_ticket.php
<?php
include 'db.php'; // Ensure your database connection is included

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $ticketId = $_GET['id']; // Get the ticket ID from the request
    $query = "SELECT * FROM tickets WHERE id = ?";
    $stmt = $db->prepare($query);
    $stmt->execute([$ticketId]);
    $ticket = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($ticket) {
        echo json_encode($ticket);
    } else {
        http_response_code(404);
        echo json_encode(['message' => 'Ticket not found']);
    }
}
?>
