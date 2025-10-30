import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:ordinary/utilities/widgets/app_bar.dart';
import 'package:ordinary/utilities/widgets/bottombar.dart';
import 'package:ordinary/views/episode_detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:ordinary/utilities/app_color.dart';
import 'package:ordinary/utilities/app_style.dart';
import '../../service/state_management/Getdata/character_store.dart';

class CharacterDetailScreen extends StatefulWidget {
  static const String route = 'character_details';
  final String characterId;
  const CharacterDetailScreen({super.key, required this.characterId});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final store = Provider.of<CharacterStore>(context, listen: false);
      await store.fetchCharacter(widget.characterId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<CharacterStore>(context);

    return Scaffold(
     appBar: CustomAppBar(),
      body: Observer(
        builder: (_) {
          if (store.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (store.character == null) {
            return const Center(child: Text("No character data available"));
          }

          final character = store.character!;
          final episodes = character.episode ?? [];

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Character Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    character.image ?? '',
                    height: 250,
                    width: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),

                // Character Name
                Text(
                  character.name ?? 'No Name',
                  style: AppStyles.getSemiBoldTextStyle(fontSize: 20),
                ),
                const SizedBox(height: 8),

                // Character Details
                Text("Gender: ${character.gender ?? 'No Data'}"),
                Text("Status: ${character.status ?? 'No Data'}"),
                Text("Species: ${character.species ?? 'No Data'}"),
                const SizedBox(height: 20),

                // Episodes Header
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Episodes:",
                    style: AppStyles.getSemiBoldTextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 20),


                Column(
                  children: episodes.map((ep) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        title: Text(ep.name ?? 'Unknown'),
                        subtitle: Text("Air Date: ${ep.airDate ?? 'Unknown'}"),
                        trailing:
                        const Icon(Icons.arrow_forward_ios, size: 16),
                        onTap: () {
                          context.pushNamed(
                            EpisodeDetailScreen.route,
                            extra: ep,
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomBar(currentIndex: 0),
    );
  }
}
