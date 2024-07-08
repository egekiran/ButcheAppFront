import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> postData() async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': 'foo',
      'body': 'bar',
      'userId': '1',
    }),
  );

  if (response.statusCode == 201) {
    var data = json.decode(response.body);
    print('Response data: $data');
  } else {
    print('Failed to post data');
    throw Exception('Failed to post data');
  }
}
