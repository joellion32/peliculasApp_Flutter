// para recorrer los datos y poder pintarlos en pantalla

class Cast{
 List<Actor> actores = new List();

  Cast.fromJsonList( List<dynamic> jsonList){
    if(jsonList == null){return;}

    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
     });
  } 
}



class Actor{
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profile_path;

 // constructor
 
Actor({
this.castId,
this.character,
this.creditId,
this.gender,
this.id,
this.name,
this.order,
this.profile_path,
});


 Actor.fromJsonMap( Map<String, dynamic> json ){
  castId =      json['castId'];
  character =   json['character'];
  creditId =    json['creditId'];
  gender =      json['gender'];
  id =          json['id'];
  name =        json['name'];
  order =       json['order'];
  profile_path = json['profile_path'];
 }


  getPhoto(){
    if(profile_path == null){
      return 'https://www.pinpng.com/pngs/m/341-3415688_no-avatar-png-transparent-png.png';
    }else{
      return 'https://image.tmdb.org/t/p/w500/$profile_path';
    }    
  }

}

