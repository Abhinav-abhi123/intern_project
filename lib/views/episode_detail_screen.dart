import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ordinary/service/state_management/counter/counter.dart';
import 'package:ordinary/utilities/app_color.dart';
import 'package:ordinary/utilities/app_style.dart';
import 'package:provider/provider.dart';
import '../model/CharacterDetailScreen.dart';
import '../utilities/widgets/episod_card.dart';

class EpisodeDetailScreen extends StatelessWidget {
  final Episode episode;
  static String route = 'EpisodeDetailScreen';

  const EpisodeDetailScreen({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    final characters = episode.characters ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(episode.name ?? "Episode Details"),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                episode.name ?? "No Name",
                style: AppStyles.getSemiBoldTextStyle(fontSize: 22),
              ),
              const SizedBox(height: 10),
              Text(
                "Air Date: ${episode.airDate ?? 'Unknown'}",
                style: AppStyles.getRegularTextStyle(fontSize: 16),
              ),
              const SizedBox(height: 10),
              Text(
                "Type: ${episode.typename ?? 'N/A'}",
                style: AppStyles.getRegularTextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),

              // ---- Characters Section ----
              Text(
                "Characters in this Episode",
                style: AppStyles.getSemiBoldTextStyle(fontSize: 18),
              ),
              const SizedBox(height: 10),

              if (characters.isEmpty)
                const Text("No characters found in this episode")
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      characters.map((character) {
                        SizedBox(height: 20,);
                        return CharacterCard(
                          imageUrl: character.image,
                          name: character.name,
                          gender: character.status,
                        );

                      }).toList(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
