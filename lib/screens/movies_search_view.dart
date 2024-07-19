import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubit/get_movies_cubit/get_movies_cubit.dart';
import 'package:movie_app/cubit/get_movies_cubit/get_movies_states.dart';
import 'package:movie_app/widgets/item_search.dart';

class MoviesSearchView extends StatelessWidget {
  const MoviesSearchView({super.key});

 static String id='movies_search_view';

  @override
  Widget build(BuildContext context) {
    String movieName=ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(movieName),
      ),
      body: BlocBuilder<GetMoviesCubit,MoviesState>(
        builder: (context, state) {
          if(state is InitialState ){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if(state is LoadingState){
            return state.listMovies.isEmpty?const Padding(
              padding:  EdgeInsets.all(20),
              child:  Center(child: Text('Not found Results, please try with another name'),),
            ): Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 4,
                  mainAxisExtent: 300,
                ),
                itemCount: state.listMovies.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ItemSearch(moviesModel: state.listMovies[index],);
                },
              ),
            );
          }else {
            return const Padding(
              padding:  EdgeInsets.all(20),
              child:  Center(
                child: Text('Not found Results, please try with another name'),
                      ),
            );}
      },
    ),
    );
  }
}