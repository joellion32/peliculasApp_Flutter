import 'dart:async';
import 'dart:convert';

import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas_app/src/models/actores_model.dart';

class PeliculasProvider {
 
  String _apiKey = 'edccbc85fd1a1017244a7b0286491c07';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _pages = 0;


List<Pelicula> _populares = new List();

final streamController = StreamController<List<Pelicula>>.broadcast();

Function(List<Pelicula>) get popularesSink => streamController.sink.add;

Stream<List<Pelicula>> get popularesStream => streamController.stream;

void dispose() {
  streamController?.close(); //Los Streams deben cerrarse cuando no se necesiten
}


  // funcion para mostrar las peliculas en cines haciendo una peticion get
  Future<List<Pelicula>> getEnCines() async{

    // generar URL
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language
    });

     return _procesarData(url);
  }


  Future<List<Pelicula>> getPopulares() async{
    _pages ++;
 
     // generar URL
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _pages.toString()
    });

// funciones para agregar mas informacion a la lista con un streambuilder
    final resp = await _procesarData(url);
    _populares.addAll(resp);
    popularesSink(_populares);

    return resp;
  }


 Future<List<Pelicula>> _procesarData(Uri url) async{
    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    // pasar los datos por el JSON
    final peliculas = new Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }

  //obtener actores
  
Future<List<Actor>> getActores(String peliId) async{
  final url = Uri.https(_url, '3/movie/$peliId/credits', {
    'api_key': _apiKey,
    'language': _language,
  });


  final resp = await http.get(url);
  final decodeData = json.decode(resp.body);  
  final cast = new Cast.fromJsonList(decodeData['cast']);

  print(decodeData['cast']);
  return cast.actores;

}



Future<List<Pelicula>> buscarPelicula(String query) async {
    // generar URL
    final url = Uri.https(_url, '3/search/movie', {
      'api_key': _apiKey,
      'language': _language,
      'query': query
    });


      return await _procesarData(url);
 
}

}// cierre de la clase