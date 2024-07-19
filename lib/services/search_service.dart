import 'package:dio/dio.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movies_model.dart';
class SearchServices {
  final Dio dio=Dio();
  String baseUrl='https://api.themoviedb.org';

  Future<List<MoviesModel>> getMovies({required String movieName}) async {
  Response response = await dio.get(
      '$baseUrl/3/search/movie?api_key=$kApiKey&&query=$movieName');
  if(response.data != null){
  List<dynamic>data=response.data['results'];
  List<MoviesModel>movingList=[];
  for(var item in data){
    movingList.add(MoviesModel.fromJson(item));
  }
  return movingList;
}else{
  throw Exception('Not found Results, please try with another name');
}
  }
}
