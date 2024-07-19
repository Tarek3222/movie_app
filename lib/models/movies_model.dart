import 'package:movie_app/screens/home_view.dart';

class MoviesModel{
  final String title;
  final String imageUrl;
  final String overView;
  final num rating;
  final String userName;
  bool isFav;
  MoviesModel( {required this.title, required this.imageUrl, required this.overView, required this.rating,required this.userName,this.isFav=false});

 factory MoviesModel.fromJson(jsonData) {
   return MoviesModel(
     title: jsonData['original_title'],
     imageUrl: jsonData['poster_path'],
     overView: jsonData['overview'],
     rating: jsonData['vote_average'],
     userName:nameId!,
     isFav: jsonData['isFav']??false,
   );
 }
}