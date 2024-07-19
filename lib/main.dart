import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubit/get_movies_cubit/get_movies_cubit.dart';
import 'package:movie_app/firebase_options.dart';
import 'package:movie_app/screens/home_view.dart';
import 'package:movie_app/screens/movies_search_view.dart';
import 'package:movie_app/screens/register_view.dart';
import 'package:movie_app/screens/sign_in_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetMoviesCubit(),
      child: MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        routes: {
          SignInView.id: (context) => const SignInView(),
          RegisterView.id: (context) => const RegisterView(),
          HomeView.id: (context) => const HomeView(),
          MoviesSearchView.id: (context) => const MoviesSearchView(),
        },
        home: const SignInView(),
      ),
    );
  }
}
