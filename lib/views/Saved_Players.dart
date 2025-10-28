import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ordinary/utilities/app_color.dart';
import 'package:ordinary/utilities/widgets/app_bar.dart';
import 'package:ordinary/utilities/widgets/bottombar.dart';
import 'package:ordinary/utilities/widgets/card_view.dart';
import '../service/state_management/AddPlayer/player_store.dart';

class SavedPlayersScreen extends StatefulWidget {
  final PlayerStore playerStore;
  static String route = 'SavedPlayersScreen';

  const SavedPlayersScreen({super.key, required this.playerStore});

  @override
  State<SavedPlayersScreen> createState() => _SavedPlayersScreenState();
}

class _SavedPlayersScreenState extends State<SavedPlayersScreen> {
  @override
  void initState() {
    super.initState();
    widget.playerStore.loadPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBar(),
      body: Observer(
        builder: (_) {
          final saved = widget.playerStore.savedPlayers;

          if (saved.isEmpty) {
            return const Center(
              child: Text(
                'No saved players yet.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return SingleChildScrollView(
            child: CardView(
              playerStore: widget.playerStore,
              showTime: false,
              showEdit: false,
              showDelete: false,
              showOnlySaved: true,
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomBar(currentIndex: 2),
    );
  }
}
