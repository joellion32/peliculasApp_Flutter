import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';
import 'package:peliculas_app/src/providers/peliculas_provider.dart';


class DataSearch extends SearchDelegate {
final peliculas = [
'Spiderman',
'Aquaman',
'Batman',
'XMEN',
'XMEN 1',
'XMEN 2',
'XMEN 3',
];

final peliculasRecientes = [
'Spiderman',
'Aquaman',
];


String seleccionado = '';
  final peliculasProvider = new PeliculasProvider();
  
  @override
  List<Widget> buildActions(BuildContext context) {
      // Acciones de nuestro Appbar
      return [
        IconButton(icon: Icon(Icons.clear), onPressed: () =>  query = '')
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icono a la izquierda del appbar
      return IconButton(icon: AnimatedIcon(icon: AnimatedIcons.menu_arrow, progress: transitionAnimation), 
      // cerrar la pantalla
      onPressed: () => close(context, null));
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // crea los resultados que vamos a mostrar
      return Center(
        child: Container(
         width: 100.0,
         height: 100.0,
         color: Colors.indigoAccent,
         child: Text(seleccionado), 
        ),
      );
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
     if(query.isEmpty){
       return Container();
     }else{
        return FutureBuilder(
          future: peliculasProvider.buscarPelicula(query),
          builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
           final peliculas = snapshot.data;
           
           if(snapshot.hasData){
             return ListView(
               children: peliculas.map((data) {
                 return ListTile(
                   title: Text(data.title),
                   subtitle: Text(data.originalTitle),
                   leading: FadeInImage(placeholder: AssetImage('assets/no-image.jpg'), image: NetworkImage(data.getPosterImg()), fit: BoxFit.cover),
                   onTap: () {
                     // cerrar busqueda
                     close(context, null);
                     Navigator.pushNamed(context, 'detalle', arguments: data);
                   },
                 );
               }).toList()
             );
           }else{
             return Center(child: CircularProgressIndicator());
           }
          },
        );
     }
    }
  



// ejemplo de como realizar una busqueda con sugerencias
  /*

 // realizar la busqueda 
    final sugeridas = (query.isEmpty) ? peliculasRecientes : peliculas.where((p) => p.toLowerCase().startsWith(query.toLowerCase())).toList();
    
    
    // Sugerencias cuando la persona escribe
    return ListView.builder(
      itemCount: sugeridas.length,
      itemBuilder: (context, i){
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(sugeridas[i]),
          onTap: () { 
           seleccionado = sugeridas[i]; 
           showResults(context);
          }
        );
      }
      );
  */

}