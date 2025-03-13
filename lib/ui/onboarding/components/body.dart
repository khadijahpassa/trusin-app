import 'package:flutter/material.dart';
import 'package:trusin_app/const.dart';
import 'package:trusin_app/main.dart';
import 'package:trusin_app/ui/onboarding/components/onboarding_content.dart';
import 'package:trusin_app/ui/onboarding/onboarding_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;

  final PageController _pageController = PageController();

  List<Map<String, String>> onboardingData = [
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
              child: SizedBox(
                  width: double.infinity,
                  child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (value) {
                        setState(() {
                          currentPage = value;
                        });
                      },
                      itemCount: onboardingData.length,
                      // itembuilder: ngebuat jembatan (jembatan antara UI dan data)
                      itemBuilder: (context, index) => OnboardingContent(
                          text: onboardingData[index]["text"]!,
                          image: onboardingData[index]["image"]!,
                          description: onboardingData[index]["description"]!))),

              // safearea: biar gak nutupin sama sistem
            ),
            // buat bikin dots indicator
            // biar gaada blank space,untuk jadiin widget kita bisa memanfaatkan ruang kosong yg ada
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // list.generate : buat ngehasilin sejumlah widet dots sesuai dengan panjang splashdata
              children: List.generate(
                  // bikin method extraction, kita pake index lagi, biar dimulai dari 0 lagi
                  onboardingData.length,
                  (index) => _dotsIndicator(index: index)),
            )),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: double.infinity,
                // elevatedbutton: paling normal, belum ada styling jadi bisa dikasih styling
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary400,
                    ),
                    //representasi dari function kosongan (jadi kita mau isi nanti)
                    //onPressed: action waktu user mau click button
                    onPressed: () {
                      // ketika currentpage nya = splash data, array itu mempresentasikan data. -1 karena dia index
                      if (currentPage == onboardingData.length - 1) {
                        // kode yang digunakan untuk berpindah antar halaman
                        Navigator.push(
                            //context: represent for our current page
                            context,
                            MaterialPageRoute(
                                builder: (context) => OnboardingScreen()));
                      } else {
                        //ini untuk swipe ke slide berikutnya, jadi kalau belum sampe slide akhir, buttonnya itu bakal menggerakkan ke halaman berikutnya dengan animatetopage
                        _pageController.animateToPage(currentPage + 1,
                            duration: animationDuration, curve: Curves.ease);
                      }
                    },
                    child: Text(
                      currentPage == onboardingData.length - 1 ? "Start" : "Next",
                      style: const TextStyle(color: Colors.white),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
AnimatedContainer _dotsIndicator({required int index}) {
    
    return AnimatedContainer(
      margin: const EdgeInsets.only(right: 10),
      // decor dots indicator
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        // ini if else untuk perubahan warna dots indicatornya
        color: currentPage == index ? primary400 : lightBlue,
      ),
      // kalau di halaman yg aktif, widthnya bakal 20 sama warnanya bakal primary, kalau gak aktif widthnya 10 sama colornya abuabu
      width: currentPage == index ? 20 : 10,
      height: 10,
      duration: animationDuration,
    );
  }

}
