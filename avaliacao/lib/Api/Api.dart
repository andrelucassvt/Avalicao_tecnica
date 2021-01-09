import 'package:http/http.dart' as https;
import 'dart:convert';

const baseUrl = 'https://api.github.com/repositories';

class Api{

  static Future getDadosRepositorios()async{
    var url = baseUrl;
    return await https.get(url);
  }
}