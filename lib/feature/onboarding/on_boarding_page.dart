import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

import '../../configuration/db/shared_preference.dart';
import '../../providers/alarm_status.dart';
import '../../providers/memo_model.dart';
import '../../providers/zero_base_model.dart';
import '../home_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    SharedPreferencesManager.instance.setOnBoardingValid();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => MultiProvider(providers: [
          ChangeNotifierProvider<ZeroBaseModel>(
            create: (context) => ZeroBaseModel(),
          ),
          ChangeNotifierProvider<MemoModel>(
            create: (context) => MemoModel(),
          ),
          ChangeNotifierProvider<AlarmStatusModel>(
            create: (context) => AlarmStatusModel(),
          )
        ], child: const HomeScreen()),
      ),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/image/zerobug.png',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/image/feeling/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold);

    PageDecoration pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: Colors.deepPurple.shade300,
      ),
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
      safeArea: 0,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      // autoScrollDuration: 3000,
      // infiniteAutoScroll: true,
      // globalHeader: Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 16, right: 16),
      //       child: _buildImage('angry.png', 100),
      //     ),
      //   ),
      // ),
      globalFooter: SizedBox(
        width: double.infinity,
        height: 80,
        child: ElevatedButton(
          child: const Text(
            'Be Sincere Every Day',
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _onIntroEnd(context),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Zero Bug",
          body: "무슨 일이든지 X0분에 맞추는 것을 \nZero Bug로 정의합니다 ",
          image: _buildImage('happy.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Example",
          body:
              "점심을 오후 1시 14분에 다 먹었을 때\n1시 20분, 1시 30분, 2시 00분에 시작하려 한다면 각각 6분, 16분, 46분의\nZeroBug가 발생합니다",
          image: _buildImage('sad.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Needs",
          body: "이 앱을 통해서 자신이 하루 동안 \nZeroBug로 인해 얼마나 많은 시간을 \n소모했는지 파악해보세요",
          image: _buildImage('angry.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Goal",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("여러분들의 발전을 ", style: bodyStyle),
              Text("기원합니다", style: bodyStyle),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 4,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('glory.png'),
          reverse: true,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
