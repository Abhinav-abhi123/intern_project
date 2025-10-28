import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ordinary/utilities/app_color.dart';
import 'package:ordinary/views/Add_players.dart';
import 'package:ordinary/views/Saved_Players.dart';
import 'package:ordinary/views/home_screen.dart';
import 'package:ordinary/views/profile.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;

  const BottomBar({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.pushNamed(HomeScreen.route);
        break;
      case 1:
        context.pushNamed(AddPlayers.route);
        break;
      case 2:
        context.pushNamed(SavedPlayersScreen.route);
        break;
      case 3:
        context.pushNamed(Profile.route);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onTap(context, index),
      backgroundColor: AppColors.pageBackground,
      selectedItemColor: AppColors.inputline,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle),
          label: 'App Players',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Saved',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
