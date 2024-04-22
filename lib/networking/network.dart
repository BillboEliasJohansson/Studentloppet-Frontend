import 'package:http/http.dart' as http;

class network {


  static Future<http.Response> callSignUp(String university, String email, String password) async {
    final response = await http
        .get(Uri.parse('https://group-15-2.pvt.dsv.su.se/studentloppet/addwithuni/'
         + email + "/" + password + "/" + university));
    return response;
  }

  static Future<http.Response> callLogIn(String email, String password) async {
    final response = await http
        .get(Uri.parse('https://group-15-2.pvt.dsv.su.se/studentloppet/login/'
         + email + "/" + password));
    return response;
  }
}
