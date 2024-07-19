import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movies_model.dart';
import 'package:movie_app/screens/movie_view.dart';

class CarouselContent extends StatelessWidget {
  const CarouselContent({super.key, required this.item});
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
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("$kBaseUrelImage${item.imageUrl}"),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            bottom: 10,
          ),
          child: Text(
            item.title,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
