import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:social_forum/business_logic/ads_provider.dart';
import 'package:social_forum/models/balance_update_model.dart';

import '../models/admob_service.dart';

class FortuneWheel extends StatefulWidget {
  const FortuneWheel({super.key});

  @override
  State<FortuneWheel> createState() => _FortuneWheelState();
}

class _FortuneWheelState extends State<FortuneWheel>
    with TickerProviderStateMixin {
  BannerAd? _banner;
  List<double> sectors = [100, 20, 0.15, 0.5, 50, 20, 100, 50, 20, 50];
  int randomSectorIndex = -1;
  List<double> sectorRadians = [];
  double angle = 0;
  bool _condition = false;
  Timer? _periodicTimer;
  Timer? _resetTimer;

  bool spinning = false;
  Random random = Random();

  late AnimationController controller;
  late Animation<double> animation;

  void generateSectorRadians() {
    double sectorRadian = 2 * pi / sectors.length;
    for (int i = 0; i < sectors.length; i++) {
      sectorRadians.add((i + 1) * sectorRadian);
    }
  }

  void recordStats() {
    context.read<WalletProvider>().earnedValue =
        sectors[sectors.length - (randomSectorIndex + 1)];
    context.read<WalletProvider>().totalEarning =
        context.read<WalletProvider>().totalEarning +
            context.read<WalletProvider>().earnedValue;
    updatePointBalance(context, context.read<WalletProvider>().totalEarning);
    context
        .read<WalletProvider>()
        .updateWallet(context.read<WalletProvider>().totalEarning);
    context.read<WalletProvider>().spins =
        context.read<WalletProvider>().spins + 1;
  }

  void spin() {
    randomSectorIndex = random.nextInt(sectors.length);
    double randomRadian = generateRadonRadianToSpinTo();
    controller.reset();
    angle = randomRadian;
    controller.forward();
  }

  double generateRadonRadianToSpinTo() {
    return (2 * pi * sectors.length) + sectorRadians[randomSectorIndex];
  }

  void startPeriodicTimer() {
    _periodicTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _condition = true;
      });
      _resetTimer?.cancel();
      _resetTimer = Timer(const Duration(seconds: 1), () {
        setState(() {
          _condition = false;
          _periodicTimer!.cancel();
        });
      });
    });
  }

  void _createBannerAds() {
    _banner = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdmobService.bannerAdsUnitId!,
        listener: AdmobService.bannerAdListener,
        request: const AdRequest())
      ..load();
  }

  @override
  void initState() {
    _createBannerAds();
    generateSectorRadians();

    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3600));
    Tween<double> tween = Tween<double>(begin: 0, end: 1);
    CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.decelerate);
    animation = tween.animate(curve);

    controller.addListener(() {
      if (controller.isCompleted) {
        setState(() {
          recordStats();
          spinning = false;
          startPeriodicTimer();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _periodicTimer?.cancel();
    _resetTimer?.cancel();
    super.dispose();
  }

  Future<void> handleSpin() async {
    WalletProvider walletProvider = context.read<WalletProvider>();
    String currentDate = DateTime.now().toIso8601String().substring(0, 10);

    if (walletProvider.spins > 290) {
      if (walletProvider.spinDate == currentDate) {
        debugPrint('spin is greater than 2');
        return;
      } else {
        walletProvider.updateSpinCount(0, '');
      }
    }

    if (!spinning) {
      spin();
      spinning = true;
      if (walletProvider.spins == 1) {
        walletProvider.updateSpinCount(2, currentDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            color: Color(0xffC2AB5C),
            image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.fill,
                opacity: 0.5)),
        child: _gameContent(),
      ),
    );
  }

  Widget _gameContent() {
    return Stack(
      children: [
        Positioned(
            top: 40.h,
            left: 20.w,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: SizedBox(
                      height: 40.h,
                      width: 40.w,
                      child: Image.asset('assets/icons/previous.png')),
                ),
                SizedBox(width: 70.w),
                Text(
                  'WATCH AND EARN',
                  style: TextStyle(fontSize: 15.sp, color: Colors.white),
                )
              ],
            )),
        Positioned(
          top: 100.h,
          left: 20.w,
          child: _banner == null
              ? Container()
              : SizedBox(
                  height: 50.h,
                  width: 320.w,
                  child: AdWidget(
                    ad: _banner!,
                  ),
                ),
        ),
        Positioned(
            top: 100.h,
            left: 90.w,
            child: Visibility(
              visible: _condition,
              child: Container(
                height: 30.h,
                width: 200.w,
                decoration: BoxDecoration(
                    color: const Color(0xffb4b2f4),
                    borderRadius: BorderRadiusDirectional.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          color: Color(0xff480073),
                          blurRadius: 1,
                          offset: Offset(0, 3.5)),
                    ]),
                child: Center(
                  child: Text(
                    'You earn ${context.read<WalletProvider>().earnedValue} from this spin',
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff480073)),
                  ),
                ),
              ),
            )),
        _gameWheel(),
        Positioned(
          top: 580.h,
          left: 80.w,
          child: _gameStats(),
        ),
      ],
    );
  }

  Widget _gameWheel() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 20.h, left: 5.w),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/belt.png'),
                fit: BoxFit.contain)),
        child: AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return Transform.rotate(
              angle: controller.value * angle,
              child: Container(
                margin:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.08),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/wheel.png'),
                        fit: BoxFit.contain)),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _gameStats() {
    return GestureDetector(
      onTap: () => handleSpin(),
      child: Container(
          height: 50.h,
          width: 200.w,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color(0xFF4cd5c0),
          ),
          child: Center(
              child: Text(
            'Play',
            style: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ))),
    );
  }
}
