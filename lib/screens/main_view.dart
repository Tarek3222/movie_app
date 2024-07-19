import 'package:flutter/material.dart';
import 'package:movie_app/widgets/carosel_builder.dart';
import 'package:movie_app/widgets/custem_text.dart';
import 'package:movie_app/widgets/movie_builder.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical:8),
      child:ListView(
        physics:const BouncingScrollPhysics(),
        children:const [
           CustomText(text: 'Now Playing'),
           SizedBox(height: 10,),
          CarouselBuilder(),
          SizedBox(height: 10,),
          CustomText(text: 'Popular Movies'),
          SizedBox(height: 10,),
          MoviesBuilder(endPoint: 'movie/popular',),
          SizedBox(height: 10,),
          CustomText(text: 'Top Rated Movies'),
          SizedBox(height: 10,),
          MoviesBuilder(endPoint: 'movie/top_rated',),
          SizedBox(height: 10,),
          CustomText(text: 'Upcoming Movies'),
          SizedBox(height: 10,),
          MoviesBuilder(endPoint: 'movie/upcoming',),
        ],
      ), 
    );
  }
}