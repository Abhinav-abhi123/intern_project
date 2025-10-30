import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ordinary/utilities/widgets/app_bar.dart';
import 'package:ordinary/utilities/widgets/bottombar.dart';
import 'package:provider/provider.dart';
import 'package:ordinary/service/state_management/GetList/char_store.dart';
import 'package:ordinary/utilities/app_color.dart';
import '../../utilities/widgets/char_card.dart';

class ViewmorePage extends StatefulWidget {
  const ViewmorePage({super.key});
  static String route = 'ViewmorePage';

  @override
  State<ViewmorePage> createState() => _ViewmorePageState();
}

class _ViewmorePageState extends State<ViewmorePage> {
  late CharacterList store;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      store = Provider.of<CharacterList>(context, listen: false);
      store.refreshCharacters();
      _initialized = true;
    }
  }

  @override
  void dispose() {
    store.resetStore();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Observer(
        builder: (_) {
          if (store.isLoading && store.characters.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (store.characters.isEmpty) {
            return const Center(child: Text('No Characters Found'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 280,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 40,
                    ),
                    itemCount: store.characters.length,
                    itemBuilder: (context, index) {
                      final character = store.characters[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.purewhite,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: CharCard(character: character),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  if (store.hasNextPage)
                    ElevatedButton(
                      onPressed: store.isLoading ? null : store.fetchCharacters,
                      child: store.isLoading
                          ? SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.fadedcolor,
                        ),
                      )
                          : const Text('View More'),
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text('No more characters'),
                    ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomBar(currentIndex: 0),
    );
  }
}
