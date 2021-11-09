import 'package:flutter/material.dart';
import 'package:my_app/Pages/Account/signin.dart';
import 'package:my_app/constants.dart';
import 'package:my_app/Pages/splash/splash_screen.dart';

// This is the best practice
import '../components/splash_content.dart';
import 'package:my_app/default_button.dart';

class Body extends StatelessWidget {
  const Body({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.black, Colors.black12],
                begin: Alignment.center,
                end: Alignment.center)
            .createShader(bounds),
        blendMode: BlendMode.darken,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/signin-background.png'),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.black12, BlendMode.darken))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Text(
                  'FOODERNITY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      // fontFamily: 'Oswald',
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      fontSize: 50,
                      decoration: TextDecoration.none,
                      letterSpacing: 4.0),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Text(
                  'Join others in donating food!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    decoration: TextDecoration.none,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class Body extends StatefulWidget {
//   @override
//   _BodyState createState() => _BodyState();
// }

// class _BodyState extends State<Body> {
//   int currentPage = 0;
//   List<Map<String, String>> splashData = [
//     {
//       "text": "Welcome to Foodernity, Let’s Go!",
//       "image": "assets/images/splash_screen_1.png"
//     },
//     {
//       "text": "Mag bigay ayon sa kakayahan,",
//       "image": "assets/images/splash_screen_2.png"
//     },
//     {
//       "text": "Kumuha batay sa pangangailangan",
//       "image": "assets/images/splash_2.png"
//     },
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SizedBox(
//         width: double.infinity,
//         child: Column(
//           children: <Widget>[
//             Expanded(
//               flex: 3,
//               child: PageView.builder(
//                 onPageChanged: (value) {
//                   setState(() {
//                     currentPage = value;
//                   });
//                 },
//                 itemCount: splashData.length,
//                 itemBuilder: (context, index) => SplashContent(
//                   image: splashData[index]["image"],
//                   text: splashData[index]['text'],
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 2,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: getProportionateScreenWidth(20)),
//                 child: Column(
//                   children: <Widget>[
//                     Spacer(),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(
//                         splashData.length,
//                         (index) => buildDot(index: index),
//                       ),
//                     ),
//                     Spacer(flex: 3),
//                     DefaultButton(
//                       text: "Continue",
//                       press: () {
//                         Navigator.pushNamed(context, Signin.routeName);
//                       },
//                     ),
//                     Spacer(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   AnimatedContainer buildDot({int index}) {
//     return AnimatedContainer(
//       duration: kAnimationDuration,
//       margin: EdgeInsets.only(right: 5),
//       height: 6,
//       width: currentPage == index ? 20 : 6,
//       decoration: BoxDecoration(
//         color: currentPage == index ? kPrimaryColor : Colors.blue,
//         borderRadius: BorderRadius.circular(3),
//       ),
//     );
//   }
// }
