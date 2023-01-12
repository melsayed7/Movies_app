import 'package:flutter/material.dart';
import 'package:movie_app/screen/browse_screen/browse_screen.dart';
import 'package:movie_app/screen/home_screen/home_screen.dart';
import 'package:movie_app/screen/search_screen/search_screen.dart';
import 'package:movie_app/screen/watch_list_screen/watch_list_screen.dart';
import 'package:movie_app/shared/style/myColor.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = 'home_screen';

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int selectedIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    SearchScreen(),
    BrowseScreen(),
    WatchListScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data:
            Theme.of(context).copyWith(canvasColor: MyColor.bottomNavBarColor),
        child: BottomNavigationBar(
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          currentIndex: selectedIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/home.png'),
              ),
              label: 'HOME',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/search.png'),
              ),
              label: 'SEARCH',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/browse.png'),
              ),
              label: 'BROWSE',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/images/watchList.png'),
              ),
              label: 'WATCHLIST',
            ),
          ],
        ),
      ),
      body: screens[selectedIndex],
    );
  }
}
