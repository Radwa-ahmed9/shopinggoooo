import 'package:flutter/material.dart';
import 'package:store_app/auth/login.dart';
import 'package:store_app/screens/home_page.dart';

class OnBoard extends StatefulWidget {
  static const String id = 'onboard_screen';

  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  Widget dotPageView() {
    return Builder(builder: ((context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < 3; i++)
            Container(
              margin: EdgeInsets.symmetric(horizontal: 7),
              width: i == pagenumber ? 25 : 6,
              height: 6,
              decoration: BoxDecoration(
                  color: i == pagenumber ? Colors.white : Colors.grey,
                  borderRadius: BorderRadius.circular(50)),
            ),
        ],
      );
    }));
  }

  PageController nextpage = PageController();
  int pagenumber = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        onPageChanged: (value) {
          setState(() {});
          pagenumber = value;
        },
        controller: nextpage,
        children: [
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 60),
                    child: Image.asset(
                      "lib/assets/130804-ORS4U4-585-removebg-preview.png",
                      width: 400.0,
                      height: 400.0,
                    ),
                  ),
                  Text(
                    "Exclusive Deals Await!",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy',
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Seamless Shopping Experience!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Gilroy Pro',
                      color: Colors.black38,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      nextpage.animateToPage(1,
                          duration: Duration(milliseconds: 700),
                          curve: Curves.easeIn);
                    },
                    child: Container(
                      height: 54,
                      width: 114,
                      decoration: BoxDecoration(
                        color: Colors.cyan.shade600,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy',
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Image.asset(
                  "lib/assets/130804-ORS4U4-585-removebg-preview.png",
                  width: 400.0,
                  height: 400.0,
                ),
              ),
              Text(
                "Shop Anytime, Anywhere!",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy',
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Your store in your pocket.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Gilroy Pro',
                  color: Colors.black38,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  nextpage.animateToPage(2,
                      duration: Duration(milliseconds: 700),
                      curve: Curves.easeIn);
                },
                child: Container(
                  height: 56,
                  width: 165,
                  decoration: BoxDecoration(
                    color: Colors.cyan.shade600,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Gilroy',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Image.asset(
                  "lib/assets/130804-ORS4U4-585-removebg-preview.png",
                  width: 400.0,
                  height: 400.0,
                ),
                Text(
                  "Customize Your Wishlist!",
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gilroy',
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Dive into our collection!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Gilroy Pro',
                    color: Colors.grey,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Login();
                    }));
                  },
                  child: Container(
                    height: 56,
                    width: 165,
                    decoration: BoxDecoration(
                      color: Colors.cyan.shade600,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Center(
                      child: Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gilroy',
                          color: Colors.white,
                        ),
                      ),
                    ),
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
