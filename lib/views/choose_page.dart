import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../utilities/app_color.dart';
import '../utilities/app_style.dart';
import 'home_screen.dart';

class CategorySelectionScreen extends StatefulWidget {
  static const String route = '/category_screen';

  const CategorySelectionScreen({Key? key}) : super(key: key);

  @override
  State<CategorySelectionScreen> createState() => _CategorySelectionScreenState();
}

class _CategorySelectionScreenState extends State<CategorySelectionScreen> {
  String selectedCategory = '';

  final List<CategoryCardModel> categoryCardList = [
    const CategoryCardModel(name: 'Show All', imagePath: 'assets/images/cb823c7318ce69ae00dcc080da35ba0b9066a10d.png'),
    const CategoryCardModel(name: 'Perfume', imagePath: 'assets/images/c9e3b7709b6de47a20f997d1a2a752e19dfd78dd.png'),
    const CategoryCardModel(name: 'Moisturizer', imagePath: 'assets/images/e41cd601eeb3e73c65ae521996fcf42f0a413221.png'),
    const CategoryCardModel(name: 'Face oils', imagePath: 'assets/images/ffa6c749180d60221e1ba21d8cd8b79fcfc3eb68.png'),
    const CategoryCardModel(name: 'Gift card', imagePath: 'assets/images/48fbfaadb60bcefd93fa2eafede876e30a4bc465.png'),
    const CategoryCardModel(name: 'Toner', imagePath: 'assets/images/072b07ede02305becd8368629b0694191044ace1.png'),
    const CategoryCardModel(name: 'Suncare', imagePath: 'assets/images/bdac9aa44485ed05ff353ed6ae1015ffe1f73a97.png'),
    const CategoryCardModel(name: 'Tools', imagePath: 'assets/images/64260f9af66522bae444c9bbae31e82cadaf47a9.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.purewhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

              Text(
                'Choose your favourite\ncategory',
                textAlign: TextAlign.center,
                style: AppStyles.getSemiBoldTextStyle(
                  fontSize: 24,
                  color: AppColors.fontColor,
                ).copyWith(height: 1.3),
              ),

              const SizedBox(height: 8),

              Text(
                'You can choose more than one',
                textAlign: TextAlign.center,
                style: AppStyles.getRegularTextStyle(
                  fontSize: 16,
                  color: AppColors.fadedText,
                ),
              ),

              const SizedBox(height: 28),

              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.only(bottom: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                    childAspectRatio: 2.6,
                  ),
                  itemCount: categoryCardList.length,
                  itemBuilder: (context, index) {
                    final category = categoryCardList[index];
                    final isSelected = selectedCategory == category.name;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category.name;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primarybutton
                              : AppColors.purewhite,
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primarybutton
                                : AppColors.evenFadedText.withOpacity(0.3),
                            width: 1.2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 3,
                              offset: const Offset(1, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Row(
                            children: [
                              Image.asset(
                                category.imagePath,
                                width: 36,
                                height: 36,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  category.name,
                                  style: AppStyles.getMediumTextStyle(
                                    fontSize: 13,
                                    color: isSelected
                                        ? AppColors.purewhite
                                        : AppColors.fontColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),

              // Continue button
              ElevatedButton(
                onPressed: () {
                  context.go(HomeScreen.route);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primarybutton,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: Text(
                  'Continue',
                  style: AppStyles.getSemiBoldTextStyle(
                    fontSize: 16,
                    color: AppColors.purewhite,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Skip button
              TextButton(
                onPressed: () {
                  context.go(HomeScreen.route);
                },
                child: Text(
                  'Skip for now',
                  style: AppStyles.getRegularTextStyle(
                    fontSize: 14,
                    color: AppColors.fadedText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCardModel {
  final String name;
  final String imagePath;

  const CategoryCardModel({
    required this.name,
    required this.imagePath,
  });
}
