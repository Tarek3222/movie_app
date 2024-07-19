import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/screens/fav_view.dart';
import 'package:movie_app/screens/main_view.dart';
import 'package:movie_app/screens/search_view.dart';
import 'package:movie_app/screens/sign_in_view.dart';
import 'package:movie_app/widgets/custom_list_tile.dart';
import 'package:movie_app/widgets/custom_nav_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  static const String id = 'home_view';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  List<Widget> screens = [
    const MainView(),
     SearchView(),
   const FavScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    var name = ModalRoute.of(context)!.settings.arguments;
    nameId=name.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Netflix',
              style:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            Text(
              'Clone',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        elevation: 0,
        width: 250,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: const Padding(
                padding: EdgeInsets.only(left: 70),
                child: Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.red,
                ),
              ),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              accountName: const Text(''),
              accountEmail: Center(child: Text(' Hello, $name')),
            ),
            CustomListTile(
                title: 'Settings', icon: Icons.settings, onTap: () {}),
            CustomListTile(
                title: 'Account', icon: Icons.account_box, onTap: () {}),
            CustomListTile(title: 'Help', icon: Icons.help, onTap: () {}),
            CustomListTile(
              title: 'Sign Out',
              icon: Icons.logout,
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.popAndPushNamed(context, SignInView.id);
              },
            ),
          ],
        ),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: CustomGoogleNav(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
String? nameId;
