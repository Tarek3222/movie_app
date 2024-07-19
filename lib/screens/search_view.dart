import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubit/get_movies_cubit/get_movies_cubit.dart';
import 'package:movie_app/screens/movies_search_view.dart';
import 'package:movie_app/widgets/carosel_builder.dart';

class SearchView extends StatelessWidget {
   SearchView({super.key});

  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView(
        children: [
          const SizedBox(height: 100,),
           TextField(
            controller: controller,
            onSubmitted: (value)async{
              var listMovies=BlocProvider.of<GetMoviesCubit>(context);
              listMovies.getMovies(movieName: value.trim());
              Navigator.pushNamed(context,MoviesSearchView.id, arguments: value.trim());
              controller.clear();
            },
            decoration:  InputDecoration(
              enabledBorder:  UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red[300]!),
              ),
              focusedBorder:  UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red[300]!),
              ),
              labelText: 'Search',
              labelStyle:const TextStyle(color: Colors.red),
              hintText: 'Enter Movie Name',
              fillColor: Colors.black,
              filled: true,
              suffixIcon:const Icon(Icons.search,color: Colors.red,),),
            ),
          const SizedBox(height: 40,),
          const CarouselBuilder(),
        ],
      )
    );
  }
}
