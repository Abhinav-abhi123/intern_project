import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../service/state_management/AddPlayer/player_store.dart';
import '../utilities/widgets/card_view.dart';
import '../utilities/widgets/bottombar.dart';
import '../utilities/widgets/app_bar.dart';
import '../utilities/widgets/player_popup.dart';
import '../utilities/app_color.dart';

class AddPlayers extends StatefulWidget {
  const AddPlayers({super.key});
  static String route = 'AddPlayers';

  @override
  State<AddPlayers> createState() => _AddPlayersState();
}

class _AddPlayersState extends State<AddPlayers> {
  late PlayerStore playerStore;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      playerStore = Provider.of<PlayerStore>(context, listen: false);
      playerStore.loadPlayers();
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<PlayerStore>(context);

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Observer(
              builder: (_) {
                if (store.players.isEmpty) {
                  return const Center(
                    child: Text(
                      "No players added yet.",
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }
                return CardView(playerStore: store);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.purewhite,
        onPressed: () {
          showPlayerPopup(context: context, store: store);
        },
        child: Icon(Icons.add, color: AppColors.popbutton),
      ),
      bottomNavigationBar: const BottomBar(currentIndex: 1),
    );
  }
}
