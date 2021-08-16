import 'package:android_projects/app_screens/form.dart';
import 'package:android_projects/utils/Utility.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:android_projects/models/movie.dart';
import 'package:android_projects/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:android_projects/utils/Utility.dart';


class MovieList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListState();
  }
}


class ListState extends State<MovieList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Movie> movieList;
  int count = 0;


  @override
  Widget build(BuildContext context) {
    if(movieList == null)
      {
        movieList = List<Movie>();
        updateListView();
      }
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Movie Roster", style:
        TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: 30,
            fontFamily: 'Lato',fontWeight: FontWeight.w300),),
        backgroundColor: Colors.black,shadowColor: Colors.yellow,),

      body: getListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("FAB");
          navigateToDetail(Movie('','',''),'          Add Movie');
        },
        child: Icon(Icons.add),
        tooltip: "Add Movie", backgroundColor: Colors.yellow,
        foregroundColor: Colors.black,
        splashColor: Colors.yellowAccent,
      ),
    );
  }

  ListView getListView() {
    TextStyle titleStyle = Theme.of(context).textTheme.subhead;
    return
      ListView.builder(

      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            title: Text(
              this.movieList[position].name,
              style: titleStyle,
            ),
            subtitle: Text(this.movieList[position].director,

            ),


            trailing: GestureDetector(
              child:

            Icon(
              Icons.delete,
              color: Colors.grey,
            ),onTap:()
              {
                _delete(context, movieList[position]);
              },
            ),
            onTap: () {
              debugPrint("List Tapped");
              navigateToDetail(this.movieList[position],'           Edit Details');

            }
          ),
        );
      },
    );
  }

  void _delete(BuildContext context,Movie movie) async
  {
    int result = await databaseHelper.deleteMovie(movie.id);
    if (result != 0) {
      _showSnackBar(context, 'Movie Deleted Successfully');
      updateListView();
    }
  }
    void _showSnackBar(BuildContext context, String message)
    {
      final snackBar=SnackBar(content: Text(message));
          Scaffold.of(context).showSnackBar(snackBar);
    }


  void navigateToDetail(Movie movie, String name)async
  {
    bool result = await Navigator.push(context,MaterialPageRoute(builder: (context)
    {
      return MovieForm(movie , name);
    }));
    if(result == true)
      {
        updateListView();
      }

  }
  void updateListView()
  {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database)
        {
          Future<List<Movie>> movielistFuture = databaseHelper.getMovieList();
          movielistFuture.then((movieList)


              {
                setState(() {
                  this.movieList = movieList;
                  this.count = movieList.length;

                });

              });
        });
  }

}

