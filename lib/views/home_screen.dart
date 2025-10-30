import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ordinary/service/api_service.dart';
import 'package:ordinary/utilities/app_color.dart';
import 'package:ordinary/utilities/app_style.dart';
import 'package:ordinary/utilities/widgets/app_bar.dart';
import 'package:ordinary/views/char_list.dart';
import '../model/Characters.dart';
import '../utilities/widgets/bottombar.dart';
import '../utilities/widgets/char_card.dart';
import 'char_details.dart';
import 'search_page.dart'; // ✅ Added

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String route = '/HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<String> categories = [
    'Trending',
    'New Products',
    'Highly Rated',
    'Rating',
    'About',
    'Visit'
  ];

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: GestureDetector(
                onTap: () {
                  context.pushNamed(SearchPage.route);
                },
                child: AbsorbPointer(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search characters...',
                      prefixIcon: Icon(Icons.search, color: AppColors.fadedcolor),
                      filled: true,
                      fillColor: AppColors.purewhite,
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: AppColors.primary),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                            color: AppColors.primarybutton, width: 1.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(child: _buildDefaultHomeView()),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(currentIndex: 0),
    );
  }

  Widget _buildDefaultHomeView() {
    return Query(
      options: QueryOptions(
        document: gql(ApiService.getCharacters),
        variables: {"page": 8},
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (result.hasException || result.data == null) {
          return const Center(child: Text('No Data'));
        }

        final characters = CharactersModel.fromJson(result.data!);
        final allCharacters = characters.characters?.results ?? [];

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Browse by categories',
                    style: AppStyles.getSemiBoldTextStyle(
                      fontSize: 16,
                      color: AppColors.fontColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              SizedBox(
                height: 35,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: categories.length,
                  separatorBuilder: (context, index) =>
                  const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final bool isSelected = selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primarybutton.withOpacity(0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primarybutton
                                : AppColors.outlineSoft,
                            width: 1,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            categories[index],
                            style: AppStyles.getRegularTextStyle(
                              fontSize: 13,
                              color: isSelected
                                  ? AppColors.primarybutton
                                  : AppColors.fadedText,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              if (allCharacters.isNotEmpty)
                SizedBox(
                  height: 300,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: allCharacters.length,
                    separatorBuilder: (context, index) =>
                    const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final character = allCharacters[index];
                      final characterId = character.id?.toString() ?? '';
                      return GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            CharacterDetailScreen.route,
                            queryParameters: {'id': characterId},
                          );
                        },
                        child: Container(
                          width: 200,
                          decoration: BoxDecoration(
                            color: AppColors.purewhite,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.15),
                                blurRadius: 4,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: CharCard(character: character),
                        ),
                      );
                    },
                  ),
                )
              else
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text("No characters found"),
                  ),
                ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product collections',
                    style: AppStyles.getSemiBoldTextStyle(
                      fontSize: 16,
                      color: AppColors.fontColor,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.pushNamed(ViewmorePage.route);
                    },
                    child: Text(
                      'View all',
                      style: AppStyles.getRegularTextStyle(
                        fontSize: 13,
                        color: AppColors.fadedText,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (allCharacters.isNotEmpty)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.purewhite,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          allCharacters.first.image ?? '',
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              allCharacters.first.name ?? 'Unknown',
                              style: AppStyles.getSemiBoldTextStyle(
                                fontSize: 14,
                                color: AppColors.fontColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              allCharacters.first.status ?? '',
                              style: AppStyles.getRegularTextStyle(
                                fontSize: 12,
                                color: AppColors.fadedText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 80),
            ],
          ),
        );
      },
    );
  }
}
