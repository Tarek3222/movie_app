import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/fav_model.dart';
import 'package:movie_app/widgets/custem_text.dart';
import 'package:http/http.dart' as http;
class MovieViewFav extends StatefulWidget {
  const MovieViewFav({super.key, required this.movie});

  final FavItemModel movie;

  @override
  State<MovieViewFav> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieViewFav> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.movie.title,),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView(
          children: [
            Container(
              height: 460,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage("$kBaseUrelImage${widget.movie.imageUrl}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10,),
            CustomText(text: widget.movie.title),
            const SizedBox(height: 5,),
            Text(widget.movie.overView,style: const TextStyle(fontSize: 16,letterSpacing: 0.1,),),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Rate: ${widget.movie.rating.toString()}',style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                IconButton(onPressed: ()async{ 
                        final url = Uri.parse(
                         'https://movie-app-95f87-default-rtdb.firebaseio.com/movies-fav/${widget.movie.id}.json');
                        final res= await  http.delete(url);
                        if (res.statusCode == 200) {
                       ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                        content: Text('Removed ${widget.movie.title} from favorites'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.white,
                  ),
                );
                setState(() {
                  widget.movie.isFav=!widget.movie.isFav;
                });
                }
                if(res.statusCode!=200){
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                  content: Text('${widget.movie.title} was not removed'),
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.red,
                  ),
                );
              }
                },
                 icon: Icon(!widget.movie.isFav?Icons.star_border:Icons.star,color: Colors.red,size: 30,)),
          ],
        ),
        ],
        ),
      ),
    );
  }
}