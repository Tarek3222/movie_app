import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/models/movies_model.dart';
import 'package:movie_app/widgets/custem_text.dart';
import 'package:http/http.dart' as http;
class MovieView extends StatefulWidget {
  const MovieView({super.key, required this.movie});

  final MoviesModel movie;

  @override
  State<MovieView> createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {

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
                  Uri url=Uri.parse('https://movie-app-95f87-default-rtdb.firebaseio.com/movies-fav.json');
                  final response=await http.post(
                    url,
                    headers: {
                      'Content-Type': 'application/json',},
                      body: json.encode({
                        "original_title":widget.movie.title,
                        "overview":widget.movie.overView,
                        "vote_average":widget.movie.rating,
                        "poster_path":widget.movie.imageUrl,
                        "isFav":true,
                        "id":widget.movie.userName,
                      })
                    );
                    if(response.statusCode==200){
                      setState(() {
                        widget.movie.isFav=!widget.movie.isFav;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added To Favorite'),showCloseIcon: true,));
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