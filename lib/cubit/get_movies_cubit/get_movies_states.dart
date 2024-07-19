import 'package:movie_app/models/movies_model.dart';

class MoviesState{}

class InitialState extends MoviesState{}
class LoadingState extends MoviesState{
  List<MoviesModel> listMovies;
  LoadingState({required this.listMovies});
}
class FailureState extends MoviesState{}