class Movie
{
  int _id;
  String _name;
  String _image;
  String _director;
  Movie(this._name,this._director,this._image);
  Movie.withId(this._id,this._name,this._director,this._image);
  int get id => _id;
  String get name => _name;
  String get director => _director;
  String get image => _image;

  set name(String newName)
  {
    if(newName.length>0) {
      this._name = newName;
    }
  }
  set director(String newDirector)
  {
    if(newDirector.length>0) {
      this._director = newDirector;
    }
  }
  set image(String newImage)
  {
    if(newImage.length>0) {
      this._image = newImage;
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
  map['image'] = _image;
  return map;

}
Movie.fromMapObject(Map<String, dynamic>map)
{
  this._id=map['id'];
  this._name=map['name'];
  this._director=map['director'];
  this._image = map['image'];
}



}