import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/models/fav_model.dart';
import 'package:movie_app/screens/home_view.dart';
import 'package:movie_app/widgets/movie_fav_item.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({super.key});

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  bool isLoading = true;
  String? error;

  Future<void> loadingMovies() async {
    final url = Uri.parse(
        'https://movie-app-95f87-default-rtdb.firebaseio.com/movies-fav.json');
    final http.Response response = await http.get(url);
    if (response.body == 'null') {
      setState(() {
        isLoading = false;
        error = 'No Movies in the Favorite list';
      });
      return;
    }
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      final List<FavItemModel> moviesList = [];
      for (final item in jsonData.entries) {
        moviesList.add(FavItemModel(
          title: item.value['original_title'],
          imageUrl: item.value['poster_path'],
          rating: item.value['vote_average'],
          overView: item.value['overview'],
          userName: item.value['id'],
          isFav: item.value['isFav'],
          id: item.key,
        ));
      }
      setState(() {
        for(var item in moviesList){
          if(item.userName==nameId){
            moviesItems.add(item);
          }
        }
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
        error = 'Failed to load data';
      });
    }
  }

  List<FavItemModel> moviesItems = [];
  @override
  void initState() {
    super.initState();
    loadingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : error != null
            ? Center(child: Text(error!))
            : moviesItems.isEmpty
                ? const Center(child: Text('No items added yet'))
                : Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListView.builder(
                        itemCount: moviesItems.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: ValueKey(moviesItems[index].id),
                            onDismissed: (_) {
                              removeItem(moviesItems[index]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: MovieItemFav(
                                movieItem: moviesItems[index],
                              ),
                            ),
                          );
                        }),
                  );
  }
  void removeItem(FavItemModel item)async {
    final int index=moviesItems.indexOf(item);
     setState(() {
      moviesItems.remove(item);
    });
    final url = Uri.parse(
        'https://movie-app-95f87-default-rtdb.firebaseio.com/movies-fav/${item.id}.json');
   final res= await  http.delete(url);

  if (res.statusCode == 200) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Removed ${item.title} from favorites'),
      showCloseIcon: true,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.white,
    ),
  );
}
   if(res.statusCode!=200){
     ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${item.title} was not removed'),
      showCloseIcon: true,
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.red,
    ),
  );
     setState(() {
       moviesItems.insert(index, item);
     });
   }    
   
  }
}

