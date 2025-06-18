import 'dart:async';

import 'package:eshop/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(24, 22, 35, 1),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // or shorthand:
            Animate(
              effects: [FadeEffect()],
              child: Center(
                child: Text(
                  "E-shop",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFE5E5E8),
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
                  "Shop at your own time!",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFE5E5E8),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                )
                .animate()
                .fade() // uses `Animate.defaultDuration`
                .scale(begin: Offset(100, 17)) // inherits duration from fadeIn
                .move(delay: 1000.ms, duration: 100.ms),
            SizedBox(height: 50),
            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(strokeWidth: 3),
                Icon(Icons.shopping_cart, size: 32, color: Colors.grey),
              ],
            ),
            Text(
                  "Loading deals...",
                  style: GoogleFonts.poppins(
                    color: const Color(0xFFE5E5E8),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                )
                .animate()
                .fadeIn(duration: 1600.ms)
                .then()
                .fadeOut(duration: 1600.ms),
          ],
        ),
      ),
    );
  }
}
