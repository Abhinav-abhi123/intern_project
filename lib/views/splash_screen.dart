import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ordinary/utilities/app_color.dart';
import 'package:ordinary/utilities/app_style.dart';
import 'choose_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Container(
                  height: 560,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/image 6.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Title
                Text(
                  'An Evolving\ncollection of treatments',
                  textAlign: TextAlign.center,
                  style: AppStyles.getBoldTextStyle(fontSize: 25),
                ),
                const SizedBox(height: 24),
                Text(
                  'The Ordinary is born to disallow\ncommodity to be disguised as ingenuity.\nThe Ordinary is "Clinical formulations\nwith Integrity".',
                  textAlign: TextAlign.center,
                  style: AppStyles.getRegularTextStyle(fontSize: 16),
                ),
                const SizedBox(height: 40),
                // Arrow button
                ElevatedButton(
                  onPressed: () {
                    context.go(CategorySelectionScreen.route);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(12),
                    backgroundColor: AppColors.primarybutton,
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                    color: AppColors.fadeicon,
                    size: 34,
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
