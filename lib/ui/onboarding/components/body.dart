import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/ui/onboarding/components/onboarding_content.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  final PageController _pageController = PageController();

  static const List<Map<String, String>> onboardingData = [
    {
      "text": "Pantau & Atur Penjualan Tanpa Ribet!",
      "image": "assets/images/onboarding_1.png",
      "description":
          "Lihat setiap tahap penjualan dengan jelas, capai target lebih cepat tanpa ribet."
    },
    {
      "text": "Closing Cepet, Cuan Melesat!",
      "image": "assets/images/onboarding_2.png",
      "description":
          "Kelola prospek dan peluang langsung dari aplikasi, jadi lebih cepat dan efisien!"
    },
    {
      "text": "Pelanggan Happy, Jualan Ngalir!",
      "image": "assets/images/onboarding_3.png",
      "description":
          "Pantau setiap peluang dan tindak lanjuti dengan tepat waktu, biar penjualan makin lancar!"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary100,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemBuilder: (context, index) => OnboardingContent(
                  text: onboardingData[index]["text"]!,
                  image: onboardingData[index]["image"]!,
                  description: onboardingData[index]["description"]!,
                ),
              ),
            ),
           
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  onboardingData.length,
                  (index) => _dotsIndicator(index: index),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  _buildButton(
                    label: "Lewati",
                    backgroundColor: secondary300,
                    textColor: text500,
                    onPressed: () => Get.toNamed('/login'),
                  ),
                  const SizedBox(width: 10),
                  _buildButton(
                    label: currentPage == onboardingData.length - 1
                        ? "Mulai"
                        : "Selanjutnya",
                    backgroundColor: primary400,
                    textColor: Colors.white,
                    onPressed: () {
                      if (currentPage == onboardingData.length - 1) {
                        Get.toNamed('/login');
                      } else {
                        _pageController.nextPage(
                          duration: animationDuration,
                          curve: Curves.ease,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton({
    required String label,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
  }) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(8), 
          ),
        ),
        onPressed: onPressed,
        child: Text(label, style: TextStyle(color: textColor)),
      ),
    );
  }

  AnimatedContainer _dotsIndicator({required int index}) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 10),
      width: currentPage == index ? 20 : 10,
      height: 10,
      duration: animationDuration,
      decoration: BoxDecoration(
        color: currentPage == index ? primary400 : lightBlue,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
