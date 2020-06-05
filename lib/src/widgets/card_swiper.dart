import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas_app/src/models/pelicula_model.dart';

class CardSwiper extends StatelessWidget{
  final List<Pelicula> peliculas;
  const CardSwiper({@required this.peliculas});
  
  @override
  Widget build(BuildContext context) {
    // mediaqueries
  final _screenSize = MediaQuery.of(context).size;
    
      return Container(
      padding: EdgeInsets.only(top: 20.0),
      width: double.infinity,
      height: 300.0,
      child: Swiper(
        itemBuilder: (BuildContext context,int index){
          return GestureDetector(
           onTap: ()=> Navigator.pushNamed(context, 'detalle', arguments: peliculas[index]),
           child:  ClipRRect(
           borderRadius: BorderRadius.circular(20.0),
           child: FadeInImage(
           placeholder: AssetImage('assets/no-image.jpg'), 
           image: NetworkImage(peliculas[index].getPosterImg()),
           fit: BoxFit.cover,
           )
          )
          );
        },
        layout: SwiperLayout.STACK,
        itemCount: peliculas.length,
        itemWidth: _screenSize.width * 0.5,
        itemHeight: _screenSize.height * 0.8,
        //pagination: new SwiperPagination(),
       // control: new SwiperControl(),
      )
    );
  }

}