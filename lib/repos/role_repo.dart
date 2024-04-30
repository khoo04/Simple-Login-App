import 'dart:convert';
import 'dart:io';

const url = "http://10.0.2.2:5000/api/User";

Future<List<dynamic>> getRoles() async {
  final getRolesURL = "$url/getRoles";
  final request = await HttpClient().getUrl(Uri.parse(getRolesURL));
  final response = await request.close();
  if (response.statusCode == HttpStatus.ok) {
    String responseBody = await response.transform(utf8.decoder).join();
    List<dynamic> parsedList = json.decode(responseBody) as List<dynamic>;
    return parsedList;
  } else {
    return [];
  }
}
