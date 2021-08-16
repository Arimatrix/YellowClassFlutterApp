class Movie
{
  int _id;
  String _name;
  
  String _director;
  Movie(this._name,this._director);
  Movie.withId(this._id,this._name,this._director);
  int get id => _id;
  String get name => _name;
  String get director => _director;

  set name(String newName)
  {
    if(newName.length<=255) {
      this._name = newName;
    }
  }
  set director(String newDirector)
  {
    if(newDirector.length<=255) {
      this._director = newDirector;
    }
  }

Map<String, dynamic>toMap()
{
  var map = Map<String, dynamic>();
  if(id!=null)
    {
      map['id']=_id;

    }
  map['name'] = _name;
  map['director'] = _director;
  return map;

}
Movie.fromMapObject(Map<String, dynamic>map)
{
  this._id=map['id'];
  this._name=map['name'];
  this._director=map['director'];
}



}