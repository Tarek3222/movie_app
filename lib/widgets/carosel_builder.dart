import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movies_model.dart';
import 'package:movie_app/services/movies_service.dart';
import 'package:movie_app/widgets/carousel_content.dart';

class CarouselBuilder extends StatelessWidget {
  const CarouselBuilder ({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MoviesModel>>(
      future: MoviesServices().getMovies(endPoint: 'movie/now_playing'),
      builder: (context,snapShot) {
        if(snapShot.hasData) {
          List<MoviesModel>listMovies=snapShot.data!;
          return CarouselSlider.builder(
                itemCount: listMovies.length,
                itemBuilder: (context, index, realIndex) => CarouselContent(item: listMovies[index],),
                options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                height: 330,
                enableInfiniteScroll: true,
                autoPlayCurve: Curves.fastOutSlowIn,    
              ),
            );
      }else if(!snapShot.hasData) {
        return const SizedBox(
          height: 330,
          child:  Center(child: CircularProgressIndicator()));
      }else {
        return const Center(child: Text('Something went wrong'));
      }
      }
    );
  }
}