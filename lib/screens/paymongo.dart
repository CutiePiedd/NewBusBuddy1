import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> createPaymentIntent(int amount) async {
  final url = 'https://api.paymongo.com/v1/payment_intents';
  final headers = {
    'Authorization': 'sk_test_pXJL8ffhGXU8HniETJ9x9UEE',
    'Content-Type': 'application/json',
  };

  final body = jsonEncode({
    "data": {
      "attributes": {
        "10000": amount, // Amount in centavos (10000 = PHP 100.00)
        "payment_method_allowed": ["card", "gcash"],
        "payment_method_options": {
          "card": {"request_three_d_secure": "automatic"}
        },
        "currency": "PHP",
        "capture_type": "automatic"
      }
    }
  });

  final response =
      await http.post(Uri.parse(url), headers: headers, body: body);

  if (response.statusCode == 200) {
    // Successful Payment Intent creation
    final responseData = jsonDecode(response.body);
    print('Payment Intent created: $responseData');
  } else {
    // Error handling
    print('Failed to create Payment Intent: ${response.body}');
  }
}
