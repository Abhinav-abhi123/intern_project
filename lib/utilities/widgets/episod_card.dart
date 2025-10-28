import 'package:flutter/material.dart';
import '../utilities.dart';



class CharacterCard extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? gender;

  const CharacterCard({
    super.key,
    this.imageUrl,
    this.name,
    this.gender,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      child: Container(
        decoration: BoxDecoration(
          color: AppColors.purewhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowSoft,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Character Image

            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius:
                const BorderRadius.horizontal(left: Radius.circular(12)),
                image: DecorationImage(
                  image: NetworkImage(imageUrl ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Character Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name ?? '',
                      style: AppStyles.getSemiBoldTextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Gender: ${gender ?? ''}',
                      style: AppStyles.getRegularTextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
