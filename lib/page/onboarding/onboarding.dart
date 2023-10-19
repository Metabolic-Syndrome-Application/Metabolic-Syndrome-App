import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/onboarding.dart';
import 'package:flutter_application_1/extension/Color.dart';
import 'package:flutter_application_1/page/loginRegister/login.dart';

void main() {
  runApp(Onboarding());
}

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Onbroading Page",
      home: OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  PageController? _controller;
  int currentIndex = 0;
  double percentage = 0.25;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }
 
  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    print(screenHeight);
    print(screenWidth);

    return Scaffold(
      backgroundColor: contentsList[currentIndex].backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: PageView.builder(
                controller: _controller,
                itemCount: contentsList.length,
                onPageChanged: (int index) {
                  if (index >= currentIndex) {
                    setState(() {
                      currentIndex = index;
                      percentage += 0.25;
                    });
                  } else {
                    setState(() {
                      currentIndex = index;
                      percentage -= 0.25;
                    });
                  }
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                              alignment: Alignment.center,
                              height: screenHeight * 0.25,
                              child: Image.asset(contentsList[index].image)),
                          SizedBox(
                            height: screenHeight * 0.078,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: screenHeight * 0.016),
                            child: Text(contentsList[index].title,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * .05),
                            child: Text(contentsList[index].discription,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'IBMPlexSansThai',
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * .05),
                child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      contentsList.length,
                      (index) => buildDot(index, context),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                  MaterialButton(
                    height: screenHeight*0.055,
                    color: Color(hexColor('#166CF7')),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(23.5),
                    ),
                    onPressed: () {
                      if (currentIndex == contentsList.length - 1) {
                        // Go to next page...
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      }
                      _controller!.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(contentsList[currentIndex].titleButton,
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'IBMPlexSansThai',
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                    ),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      height: 11,
      width: currentIndex == index ? 11 : 11,
      margin: const EdgeInsets.only(left: 8, right: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? Colors.white : Colors.white38,
      ),
    );
  }
}
