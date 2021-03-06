import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/actores_model.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';


class PeliculaDetalle extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    // recibir parametros del pushnamed
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _crearAppbar(pelicula),
          // agregar mas widgets
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox( height: 10.0  ),
                _posterTitulo(context, pelicula),
                _contenido(pelicula),
                _contenido(pelicula),
                _contenido(pelicula),
                _actores(pelicula)
              ]
            ),
          )
        ],
      )
    );
  }


  Widget _crearAppbar(Pelicula pelicula){
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,  
      title: Text(pelicula.title, style: TextStyle(color: Colors.white, fontSize: 16.0)),
      background: FadeInImage(
        placeholder: AssetImage('assets/loading.gif'), 
        image: NetworkImage(pelicula.getBackImg()),
        fit: BoxFit.cover),
      ),
    );
  }

  // poster titulo
  Widget _posterTitulo(BuildContext context, Pelicula pelicula){
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20.0 ),
      child: Row(
       children: <Widget>[
         Hero(
          tag: pelicula.id,
          child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0), 
          child: Image(image: NetworkImage(pelicula.getPosterImg()), height: 150.0),
         )
         ),
         SizedBox( width: 20.0),

         Flexible(
          child: Column(
            // para ordernar cerca de la imagen
          crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[
             Text(pelicula.title, style: Theme.of(context).textTheme.headline6, overflow: TextOverflow.ellipsis),
             Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis),
             Row(
             children: <Widget>[
               Icon( Icons.star_border ),
               Text(pelicula.voteAverage.toString())
             ],
             )  
           ],  
           )
        )
       ],
      ),
    );
  }

  Widget _contenido(Pelicula pelicula){
   return Flexible(
     child: Container(
       padding: EdgeInsets.symmetric( horizontal: 10.0, vertical: 15.0 ),
       child: Text(pelicula.overview, textAlign: TextAlign.justify),
     )
     ); 
  }


Widget _actores(Pelicula pelicula){
  final peliculasProvider = new PeliculasProvider();

// para recibir nuestro servicio
    return FutureBuilder(
      future: peliculasProvider.getActores(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
        return _crearActoresPageView(snapshot.data);
        }else{
         return Center(
           child: CircularProgressIndicator()
         );
        }
      },
    );
  }

 Widget _crearActoresPageView(List<Actor> actores){

   return SizedBox(
     height: 200.0,
     child: PageView.builder(
       controller: PageController(
         viewportFraction: 0.3,
         initialPage: 1
       ),
        itemCount: actores.length,
        itemBuilder: (contex, i){
          return _targetasActores(actores[i]);
        },
       ),
   );
 }

 // targetas para actores
 Widget _targetasActores(Actor actores){
   return Container(
     padding: EdgeInsets.symmetric( horizontal: 15.0 ),
     child: Column(
       children: <Widget>[
         Divider(),
         ClipRRect(
           borderRadius: BorderRadius.circular(20.0),
           child: FadeInImage(height: 150.0,  placeholder: AssetImage('assets/no-image.jpg'), image: NetworkImage(actores.getPhoto()), fit: BoxFit.cover)
         ),
         Text(actores.name, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center)
       ],
     ),
   );
 }

} // ceierre de la clase