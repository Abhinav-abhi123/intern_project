import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
import '../utilities/widgets/episod_card.dart';
import 'char_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String route = '/HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  final List<String> categories = ['Trending', 'New Products', 'Highly Rated','Rating'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar:const CustomAppBar(),
      body: SafeArea(
        child: Query(
          options: QueryOptions(
            document: gql(ApiService.getCharacters),
            variables: {"page":8}

          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (result.hasException || result.data == null) {
              return const Center(child: Text('No Data'));
            }

            final characters = CharactersModel.fromJson(result.data!);
            log("characters: ${jsonEncode(characters)}");

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 12),


                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.purewhite,
                      hintText: 'Search characters',
                      hintStyle: AppStyles.getRegularTextStyle(
                        fontSize: 14,
                        color: AppColors.evenFadedText,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.evenFadedText,
                        size: 20,
                      ),
                      contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: AppColors.outline),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                        BorderSide(color: AppColors.primary, width: 1.5),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),


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
                      Text(
                        'View all',
                        style: AppStyles.getRegularTextStyle(
                          fontSize: 13,
                          color: AppColors.fadedText,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),


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
                                horizontal: 20, vertical: 8),
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

                  /// --- Horizontal Character Cards ---
                  if (characters.characters?.results != null &&
                      characters.characters!.results!.isNotEmpty)
                    SizedBox(
                      height: 320,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: characters.characters!.results!.length,
                        separatorBuilder: (context, index) =>
                        const SizedBox(width: 12),
                        itemBuilder: (context, index) {
                          final character =
                          characters.characters!.results![index];
                          return GestureDetector(
                            onTap: () {
                              context.pushNamed(
                                CharacterDetailScreen.route,
                                queryParameters: {'id': character.id},
                              );
                            },
                            child: Container(
                              width: 200,
                              decoration: BoxDecoration(
                                color: AppColors.purewhite,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.purewhite,
                                    blurRadius: 2,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: CharCard(character: character),
                            ),
                          );
                        },
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


                    if (characters.characters?.results != null &&
                        characters.characters!.results!.isNotEmpty)
                      CharacterCard(
                        imageUrl: characters.characters!.results!.first.image,
                        name: characters.characters!.results!.first.name,
                        gender: characters.characters!.results!.first.status,
                      ),

                  const SizedBox(height: 80),
                ],
              ),
            );
          },
        ),
      ),

      bottomNavigationBar:BottomBar(currentIndex: 0,),
    );
  }
}
