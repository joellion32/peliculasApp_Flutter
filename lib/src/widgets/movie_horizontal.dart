import 'package:flutter/material.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';


class MovieHorizontal extends StatelessWidget{
  final List<Pelicula> peliculas; 
  final Function siguientePagina;


  const MovieHorizontal({@required this.peliculas, @required this.siguientePagina});
  
  @override
  Widget build(BuildContext context) {
    // controladores
    final _pageController = new PageController(initialPage: 1, viewportFraction: 0.3); 
    final _screenSize = MediaQuery.of(context).size;


    // verificar scroll
    _pageController.addListener(() {
      if(_pageController.position.pixels >= _pageController.position.maxScrollExtent){
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView(
       controller: _pageController,   
       children:  _targetas(context)   
      ),
    );
  }


// crear tarjetas 
List<Widget> _targetas(BuildContext context){
return peliculas.map((pelicula) {

final tarjeta = Container(
margin: EdgeInsets.only( right: 15.0 ),
child: Column(
 children: <Widget>[
   Expanded(
  child: Hero(
    tag: pelicula.id, 
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: FadeInImage(
      placeholder: AssetImage('assets/no-image.jpg'), 
      image: NetworkImage(pelicula.getPosterImg()),
      fit: BoxFit.cover,
      height: 160.0,
    )
   ),
   )
  ),
    Text(
      pelicula.title,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.caption,
    )
 ],
),
);

return GestureDetector(
child: tarjeta,
onTap: (){
Navigator.pushNamed(context, 'detalle', arguments: pelicula);
},
);
}).toList();

}

// para hacer click en una targeta



} // cierre de la clase