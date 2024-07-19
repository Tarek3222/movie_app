import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/fav_model.dart';
import 'package:movie_app/screens/movie_view_fav.dart';

class MovieItemFav extends StatelessWidget {
  const MovieItemFav({super.key, required this.movieItem});
  final FavItemModel movieItem;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => MovieViewFav(movie: movieItem,)));
        },
        shape:RoundedRectangleBorder(
          side: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10)),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage("$kBaseUrelImage${movieItem.imageUrl}"),),
        title: Text(movieItem.title, style: const TextStyle(fontSize: 20),),
        subtitle: Text(movieItem.rating.toString()),
      ),
    );
  }
}