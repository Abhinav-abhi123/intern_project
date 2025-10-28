import 'package:flutter/material.dart';
import 'package:ordinary/utilities/widgets/app_bar.dart';

import '../utilities/widgets/bottombar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
static String route='Profile';
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(child: Text('profle'),),
      bottomNavigationBar: const BottomBar(currentIndex: 3,),
    );

  }
}
