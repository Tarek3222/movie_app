import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movies_model.dart';
import 'package:movie_app/screens/movie_view.dart';

class ItemMovie extends StatelessWidget {
  const ItemMovie({super.key, required this.item});
  final MoviesModel item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieView(
              movie: item,
            ),
          ),
        );
      },
      child: Container(
        height: 200,
        width: 130,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: NetworkImage("$kBaseUrelImage${item.imageUrl}"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}