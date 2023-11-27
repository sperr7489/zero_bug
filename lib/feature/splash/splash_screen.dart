import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

import '../../configuration/db/shared_preference.dart';
import '../../providers/alarm_status.dart';
import '../../providers/memo_model.dart';
import '../../providers/zero_base_model.dart';
import '../home_screen.dart';
import '../onboarding/on_boarding_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoaded = false;
  bool _onBoardingValid = false;
  @override
  void initState() {
    SharedPreferencesManager.instance.getOnBoardingValid().then((value) {
      setState(() {
        _onBoardingValid = value;
      });
    });

    super.initState();
    Future.delayed(const Duration(seconds: 5)).then((value) => setState(() {
          isLoaded = true;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateWhere: isLoaded,
      navigateRoute: MultiProvider(
        providers: [
          ChangeNotifierProvider<ZeroBaseModel>(
            create: (context) => ZeroBaseModel(),
          ),
          ChangeNotifierProvider<MemoModel>(
            create: (context) => MemoModel(),
          ),
          ChangeNotifierProvider<AlarmStatusModel>(
            create: (context) => AlarmStatusModel(),
          )
        ],
        child: _onBoardingValid ? const HomeScreen() : const OnBoardingPage(),
      ),
      backgroundColor: Colors.white,
      linearGradient: const LinearGradient(
          colors: [
            Color.fromARGB(255, 161, 176, 222),
            Color(0xFF00CCFF),
          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.mirror),
      text: WavyAnimatedText(
        "Zero Bug",
        textStyle: const TextStyle(
          color: Color.fromARGB(255, 21, 54, 88),
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      imageSrc: "assets/image/zerobug.png",
      logoSize: 200,
      // displayLoading: false,
    );
  }
}
