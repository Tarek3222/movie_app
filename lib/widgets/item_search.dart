import 'package:flutter/material.dart';
import 'package:movie_app/models/movies_model.dart';
import 'package:movie_app/widgets/item_movie.dart';

class ItemSearch extends StatelessWidget {
  const ItemSearch({super.key, required this.moviesModel});
  final MoviesModel moviesModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ItemMovie(item: moviesModel),
        const SizedBox(height: 10,),
        Text(moviesModel.title),
      ],
    );
  }
}