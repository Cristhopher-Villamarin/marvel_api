import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import '../models/api_marvel_model.dart';

class ControladorDatos {
  final String _urlBase = "https://gateway.marvel.com/v1/public/characters";
  final String _publicKey = "d41490e7b83fe157f8fbe108c2fd87f7";
  final String _privateKey = "d87300a1325a944497c56df63b9d031b82594b3b";

  String _generateHash(String timestamp) {
    final input = timestamp + _privateKey + _publicKey;
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<List<Datos>> obtenerDatos() async {
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    final String hash = _generateHash(timestamp);
    final String url =
        "$_urlBase?ts=$timestamp&apikey=$_publicKey&hash=$hash";

    final respuesta = await http.get(Uri.parse(url));

    if (respuesta.statusCode == 200) {
      final List<dynamic> datos = json.decode(respuesta.body)['data']['results'];
      return datos.map((json) => Datos.fromJson(json)).toList();
    } else {
      throw Exception("Error al cargar los datos: ${respuesta.statusCode}");
    }
  }
}
