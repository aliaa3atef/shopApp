import 'package:flutter/material.dart';
import 'package:shop_app/modules/shopLogin/shopLoginScreen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cashedHelper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoard {
  final String image, title, body;

  OnBoard(this.image, this.title, this.body);
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var pageController = PageController();

  List<OnBoard> onBoardItems = [
    OnBoard('assets/images/onBoard.png', 'Screen title 1', 'Screen body 1'),
    OnBoard('assets/images/onBoard2.png', 'Screen title 2', 'Screen body 2'),
    OnBoard('assets/images/onBoard3.jpg', 'Screen title 3', 'Screen body 3'),
  ];

  bool isLast = false;

  void submit(){
    CashedHelper.setData(key: 'onBoarding', value: true).then((value){
      navigateAndReplace(context: context, screen: ShopLoginScreen());
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          sharedTextButton(
              onPress: submit,
              text: "SKIP"),
        ],
      ),
      body: PageView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Image(
                        image: AssetImage('${onBoardItems[index].image}'))),
                Text(
                  "${onBoardItems[index].title}",
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text("${onBoardItems[index].body}",
                    style: Theme.of(context).textTheme.bodyText1),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SmoothIndicator(
                      offset: index.toDouble(),
                      count: 3,
                      effect: ExpandingDotsEffect(
                        activeDotColor: colorApp,
                      ),
                    ),
                    Spacer(),
                    FloatingActionButton(
                      onPressed: () {
                        isLast
                            ? submit()
                            : pageController.nextPage(
                                duration: Duration(milliseconds: 750),
                                curve: Curves.fastLinearToSlowEaseIn,
                              );
                      },
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                )
              ],
            ),
          );
        },
        itemCount: onBoardItems.length,
        physics: BouncingScrollPhysics(),
        controller: pageController,
        onPageChanged: (index) {
          if (index == onBoardItems.length - 1) {
            setState(() {
              isLast = true;
            });
          } else {
            setState(() {
              isLast = false;
            });
          }
        },
      ),
    );
  }
}
