import 'package:dio/dio.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movies_model.dart';

class MoviesServices {
 final Dio dio=Dio();
  Future<List<MoviesModel>> getMovies({required String endPoint}) async {
    String baseUrl='https://api.themoviedb.org';
    final Response response=await dio.get('$baseUrl/3/$endPoint?api_key=$kApiKey');
    try {
  List<dynamic>data=response.data['results'];
  List<MoviesModel>movingList=[];
  for(var item in data){
    movingList.add(MoviesModel.fromJson(item));
  }
  return movingList;
} catch (e) {
  return [];
}
  }
}