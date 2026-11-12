import 'package:flutter/material.dart';
import '../../functions/boarding.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/boardingitem.dart';
import '../../widgets/custom_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final OnboardingController controller = OnboardingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _buildFallbackIllustration(IconData icon) {
    return Container(
      width: 140,
      height: 140,
      decoration: const BoxDecoration(
        color: AppColors.primaryDark,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(icon, size: 70, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 520),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool isShort = constraints.maxHeight < 600;

                return Column(
                  children: [
                    // Top Bar with Skip Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => controller.skipToLogin(context),
                            child: Text(
                              'SKIP',
                              style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Slides PageView
                    Expanded(
                      child: PageView.builder(
                        controller: controller.pageController,
                        itemCount: onboardingList.length,
                        onPageChanged: (index) {
                          setState(() {
                            controller.changePage(index);
                          });
                        },
                        itemBuilder: (context, index) {
                          final item = onboardingList[index];

                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: isShort ? 8 : 16,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Center(
                                    child: item.image.startsWith('http')
                                        ? Image.network(
                                            item.image,
                                            fit: BoxFit.contain,
                                            errorBuilder: (_, _, _) =>
                                                _buildFallbackIllustration(item.fallbackIcon),
                                          )
                                        : Image.asset(
                                            item.image,
                                            fit: BoxFit.contain,
                                            errorBuilder: (_, _, _) =>
                                                _buildFallbackIllustration(item.fallbackIcon),
                                          ),
                                  ),
                                ),
                                SizedBox(height: isShort ? 12 : 24),
                                Text(
                                  item.title,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.headingMedium.copyWith(
                                    fontSize: isShort ? 22 : 26,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(height: isShort ? 8 : 12),
                                Text(
                                  item.description,
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.bodySmall.copyWith(
                                    fontSize: isShort ? 12 : 14,
                                    color: AppColors.textSecondary,
                                    height: 1.4,
                                  ),
                                ),
                                SizedBox(height: isShort ? 12 : 24),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    // Page Indicators
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: onboardingList.asMap().entries.map((entry) {
                        final int index = entry.key;
                        final bool isSelected = controller.currentPage == index;

                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: isSelected ? 26 : 8,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryDark
                                : const Color.fromARGB(255, 211, 214, 220),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: isShort ? 14 : 24),

                    // Action Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: CustomElevatedButton(
                        text: controller.currentPage == onboardingList.length - 1
                            ? 'GET STARTED'
                            : 'NEXT',
                        backgroundColor: AppColors.primaryDark,
                        foregroundColor: Colors.white,
                        width: double.infinity,
                        height: isShort ? 48 : 54,
                        radius: 27,
                        onTap: () {
                          setState(() {
                            controller.nextPage(context, onboardingList.length);
                          });
                        },
                      ),
                    ),
                    SizedBox(height: isShort ? 14 : 24),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
