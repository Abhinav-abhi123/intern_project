import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(60); // 👈 required by Scaffold

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.5,
      automaticallyImplyLeading: false,
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: 18, top: 12, bottom: 14),
        child: SvgPicture.asset(
          'assets/icons/menu.svg',
          width: 18,
          height: 18,
        ),
      ),
      title: const Padding(
        padding: EdgeInsets.only(top: 15),
        child: Text(
          "Ordinary",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 16),
          child: SvgPicture.asset(
            'assets/icons/notification.svg',
            width: 22,
            height: 22,
          ),
        ),
      ],
    );
  }
}
