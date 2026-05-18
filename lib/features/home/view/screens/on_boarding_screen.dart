import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/utils/assets_image/image_model.dart';
import 'package:tasky/features/auth/view/screens/register_screen.dart';
import 'package:tasky/features/home/data/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = "onboarding";

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController controller = PageController();
  int currentIndex = 0;

  List<OnboardingModel> pages = [
    OnboardingModel(
      title: "Manage your tasks",
      description:
          "You can easily manage all of your daily tasks in DoMe for free",
      image: ImageClass.undrawSoftwareEngineer,
    ),
    OnboardingModel(
      title: "Create daily routine",
      description:
          "In Tasky  you can create your personalized routine to stay productive",
      image: ImageClass.undrawTimeManagement,
    ),
    OnboardingModel(
      title: "Orgonaize your tasks",
      description:
          "You can organize your daily tasks by adding your tasks into separate categories",
      image: ImageClass.undrawCalendar,
    ),
  ];

  void finishOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("seenOnboarding", true);

    Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(pages[index].image),
                      const SizedBox(height: 20),
                      Text(
                        pages[index].title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        pages[index].description,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              pages.length,
              (index) => Container(
                margin: const EdgeInsets.all(4),
                width: currentIndex == index ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: currentIndex == index ? Colors.blue : Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: finishOnboarding,
                  child: const Text("Next"),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (currentIndex < pages.length - 1) {
                      controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    } else {
                      finishOnboarding();
                    }
                  },
                  child: Text(
                    currentIndex == pages.length - 1 ? "Get Started" : "Next",
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
