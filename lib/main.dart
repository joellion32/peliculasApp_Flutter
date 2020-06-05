import 'package:flutter/material.dart';
import 'package:peliculas_app/src/pages/home_page.dart';
import 'package:peliculas_app/src/pages/pelicula_detalle.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Peliculas App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        'detalle': (context) => PeliculaDetalle(),
      }
    );
  }
}
