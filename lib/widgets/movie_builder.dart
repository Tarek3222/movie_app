import 'package:flutter/material.dart';
import 'package:movie_app/models/movies_model.dart';
import 'package:movie_app/services/movies_service.dart';
import 'package:movie_app/widgets/item_movie.dart';

class MoviesBuilder extends StatelessWidget {
  const MoviesBuilder ({super.key, required this.endPoint});
  final String endPoint;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MoviesModel>>(
      future: MoviesServices().getMovies(endPoint: endPoint),
      builder: (context,snapShot) {
        if(snapShot.hasData) {
          List<MoviesModel>listMovies=snapShot.data as List<MoviesModel>;
          return SizedBox(
            height: 200,
            child: ListView.builder(
                  itemCount: listMovies.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => ItemMovie(item: listMovies[index],),
              ),
          );
      }else if(!snapShot.hasData) {
        return  const SizedBox(
          height: 200,
          child: Center(child: CircularProgressIndicator()));
      }else {
        return const Center(child: Text('Something went wrong'));
      }
      }
    );
  }
}