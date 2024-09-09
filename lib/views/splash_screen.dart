import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double logoHeight = 60;
  double logoWidth = 60;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {
      increaseSize();
    });
    super.initState();
  }

  void increaseSize() {
    if (mounted) {
      setState(() {
        logoHeight += 85;
        logoWidth += 85;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              width: logoWidth,
              height: logoHeight,
              duration: const Duration(seconds: 1),
              curve: Curves.bounceOut,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset('assets/images/logo.jpeg'),
            ),
          ],
        ),
      ),
    );
  }
}
