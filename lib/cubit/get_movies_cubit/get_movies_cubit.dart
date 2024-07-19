import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubit/get_movies_cubit/get_movies_states.dart';
import 'package:movie_app/models/movies_model.dart';
import 'package:movie_app/services/search_service.dart';

class GetMoviesCubit extends Cubit<MoviesState> {

  GetMoviesCubit() : super(InitialState());
  List<MoviesModel>?listMovies;
    getMovies({required String movieName}) async {
   try {
   listMovies= await SearchServices().getMovies(movieName: movieName);
  emit(LoadingState(
    listMovies: listMovies!
  ));
}  catch (e) {
  emit(FailureState());
}

  }

}