import 'package:flutter/material.dart';

import '../utilities.dart';



class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.text,
    this.isSelected = false,
  });

  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.purewhite,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? AppColors.primarybutton : AppColors.outlineSoft, width: 1),
      ),
      child: Text(
        text,
        style: AppStyles.getRegularTextStyle(
            fontSize: 13, color: isSelected ? AppColors.primarybutton : AppColors.fadedText),
      ),
    );
  }
}