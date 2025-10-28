
import 'package:flutter/material.dart';
import '../utilities.dart';
import '../../model/Characters.dart';

class CharCard extends StatelessWidget {
  const CharCard({
    super.key,
    required this.character,
  });

  final Result character;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 130,
          decoration: BoxDecoration(
            color: AppColors.imagePlaceholder,
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12)),

          ),
          child: Center(
            child: Image.network(
              character.image ?? '',
              height: 140,
              fit: BoxFit.contain,
              errorBuilder:
                  (context, error, stackTrace) {
                return Container(
                  height: 140,
                  width: 60,
                  color: AppColors.purewhite,
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Text(
                character.name ?? '',
                style: AppStyles.getSemiBoldTextStyle(
                    fontSize: 15),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                'Gender: ${character.gender ?? ''}',
                style: AppStyles.getRegularTextStyle(
                    fontSize: 12),
              ),
              const SizedBox(height: 2),
              Text(
                'Species: ${character.id ?? ''}',
                style: AppStyles.getRegularTextStyle(
                    fontSize: 12),
              ),
              const SizedBox(height: 2),
              Text(
                'Status: ${character.status ?? ''}',
                style: AppStyles.getRegularTextStyle(
                    fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
