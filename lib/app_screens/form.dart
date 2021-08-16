import 'package:android_projects/models/movie.dart';
import 'package:android_projects/utils/Utility.dart';
import 'package:android_projects/utils/database_helper.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class MovieForm extends StatefulWidget {
  final String appBarTitle;
  final Movie movie;

  MovieForm(this.movie, this.appBarTitle);
  @override
  State<StatefulWidget> createState() {
    return MovieState(this.movie, this.appBarTitle);
  }
}

class MovieState extends State<MovieForm> {
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  Movie movie;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController ImageController = TextEditingController();

  MovieState(this.movie, this.appBarTitle);
 String pickImageFromGallery() {
    ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile) {
      String imgString = Utility.base64String(imgFile.readAsBytesSync());
       movie.image=imgString;
    });

  }
  getImageAsset() {
    return Padding(
      padding: EdgeInsets.only(left:10.0,right: 10.0,bottom:10.0, top :10.0),
      child: Utility.imageFromBase64String(movie.image)
    );
        }


  @override
  Widget build(BuildContext context) {
    titleController.text = movie.name;
    descriptionController.text = movie.director;

    return WillPopScope(
    onWillPop: (){
      moveToLastScreen();
    },child:
      Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          appBarTitle,
          style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
              fontSize: 30,
              fontFamily: 'Lato',
              fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.black,
        shadowColor: Colors.yellow,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: ListView(
          children: <Widget>[



            getImageAsset(),//Movie Name
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                  controller: titleController,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w300,
                      ),
                  onChanged: (value) {
                    updateTitle();
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter Movie Name',
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic),
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ))),
            ),
            //Director Name
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                  controller: descriptionController,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w300,
                      ),
                  onChanged: (value) {
                    updateDescription();
                  },
                  decoration: InputDecoration(
                      labelText: 'Enter Director Name',
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w300,
                          fontStyle: FontStyle.italic),
                      enabledBorder: const OutlineInputBorder(
                        // width: 0.0 produces a thin "hairline" border
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ))),
            ),

            //Add/Modify Image Button
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              width: 300.0,
              height: 60.0,
              child: RaisedButton(
                color: Colors.yellow,
                child: Text(
                  "Add/Modify Poster",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Lato',
                      fontSize: 30.0,
                      fontWeight: FontWeight.w300),
                ),
                elevation: 6.0,
                onPressed: () {
                  setState(() {
                    debugPrint("Converting");
                    pickImageFromGallery();

                  });
                },
              ),
            ),
            //Save Button
            Container(
              margin: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 14),
              width: 300.0,
              height: 60.0,
              child: RaisedButton(
                color: Colors.yellow,
                child: Text(
                  "Save",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Lato',
                      fontSize: 30.0,
                      fontWeight: FontWeight.w300),
                ),
                elevation: 6.0,
                onPressed: () {
                  setState(() {
                    debugPrint("Save");
                    _save();
                  });
                },
              ),
            ),
            Container(width: 5.0),

            //Delete Button
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
              width: 300.0,
              height: 60.0,
              child: RaisedButton(
                color: Colors.grey,
                child: Text(
                  "Delete",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lato',
                      fontSize: 30.0,
                      fontWeight: FontWeight.w300),
                ),
                elevation: 6.0,
                onPressed: () {
                  setState(() {
                    debugPrint("Delete");
                    _delete();
                  });
                },
              ),
            )
          ],
        ),
      ),
    ),
    );
  }
/*
  Widget getImageAsset() {
   Movie movie;
   movie.image;
    AssetImage assetImage = Utility.imageFromBase64String(movie.image) as AssetImage;
    Image image = Image(
      image: assetImage,
      width: 350.0,
      height: 300.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.only(bottom: 10),
    );
  }

 */


  void updateTitle() {
    movie.name = titleController.text;
  }

  void updateDescription() {
    movie.director = descriptionController.text;
  }
  void updateImage()
  {
    movie.image = ImageController.text;
  }

  void _save() async {
    moveToLastScreen();


    int result;
    if (movie.id != null) {
      result = await helper.updateMovie(movie);
    } else {
      result = await helper.insertMovie(movie);
    }
    if (result != 0) //passed
    {
      _showAlertDialog('Status', 'Movie Saved Successfully');
    } else {
      _showAlertDialog('Status', 'Movie Saved Successfully');
    }
  }

  void _showAlertDialog(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _delete() async {
    moveToLastScreen();
    if (movie.id == null) {
      _showAlertDialog('Status', 'No Movies Present');
      return;
    }
    int result = await helper.deleteMovie(movie.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Movie Deleted');
    } else {
      _showAlertDialog('Status', 'Error');
    }
  }

}
