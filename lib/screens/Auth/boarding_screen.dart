import 'package:car_rental_system/functions/boarding.dart';
import 'package:car_rental_system/widgets/boardingitem.dart';
import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_text_styles.dart';
import '../../widgets/custom_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  OnboardingController controller = OnboardingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
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
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(item.image, fit: BoxFit.contain),
                        ),

                        SizedBox(height: 25),

                        Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.heading,
                        ),

                        SizedBox(height: 12),

                        Text(
                          item.description,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.subtitle,
                        ),

                        SizedBox(height: 30),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: onboardingList.asMap().entries.map((entry) {
                int index = entry.key;

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: controller.currentPage == index ? 25 : 8,
                  decoration: BoxDecoration(
                    color: controller.currentPage == index
                        ? AppColors.primary
                        : Colors.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 25),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: CustomElevatedButton(
                text: controller.currentPage == onboardingList.length - 1
                    ? 'GET STARTED'
                    : 'NEXT',
                width: double.infinity,
                height: 55,
                radius: 15,
                onTap: () {
                  setState(() {
                    controller.nextPage(context, onboardingList.length);
                  });
                },
              ),
            ),

            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
