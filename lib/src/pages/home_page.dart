import 'package:flutter/material.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';
import 'package:peliculas_app/src/search/search_delegate.dart';
import 'package:peliculas_app/src/widgets/card_swiper.dart';
import 'package:peliculas_app/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
// el servicio
  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {
  // llamar servicio de populares
  peliculasProvider.getPopulares();


    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicacion de Peliculas'),
        //centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), 
          onPressed: () {
            showSearch(context: context, delegate: DataSearch());
          })
        ],
      ),
      body: Container(
        //padding: EdgeInsets.only( top: 5.0 ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[_swiperTargetas(), _footer(context)],
        ),
      ),
    );
  }

// widget para crear carrousel de targetas
  Widget _swiperTargetas() {
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        // verificar si llegan los datos
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      padding: EdgeInsets.only( left: 20.0 ),
      width: double.infinity,
    
      child: Column(
        children: <Widget>[
          Center(child: Text('Populares',style: Theme.of(context).textTheme.subtitle1)),
          SizedBox( height: 20.0),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(peliculas: snapshot.data, siguientePagina: peliculasProvider.getPopulares);
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }
} // cierre de la clase
