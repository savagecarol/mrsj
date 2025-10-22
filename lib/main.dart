import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'patakajanhvisingh.com',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 1));
  final ConfettiController _bigConfettiController =
      ConfettiController(duration: const Duration(seconds: 2));

  late AnimationController _shakeController;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  void _handleTap() => _confettiController.play();
  void _handleDoubleTap() => _confettiController.play();
  void _handleLongPress() => _bigConfettiController.play();

  @override
  void dispose() {
    _confettiController.dispose();
    _bigConfettiController.dispose();
    _shakeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shakeAnim = Tween<double>(begin: -3, end: 3).animate(
        CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut));

    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: Stack(
        children: [
          // Center confetti
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              numberOfParticles: 25,
              gravity: 0.2,
              colors: const [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.purple,
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ConfettiWidget(
              confettiController: _bigConfettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              numberOfParticles: 50,
              gravity: 0.3,
              colors: const [
                Colors.red,
                Colors.orange,
                Colors.yellow,
                Colors.green,
                Colors.purple,
              ],
            ),
          ),

          // Glitter header top
          Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: shakeAnim,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(shakeAnim.value, 0),
                  child: Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.pinkAccent,
                      highlightColor: Colors.yellowAccent,
                      period: const Duration(milliseconds: 1000),
                      child: Text(
                        "✨ Sab piyo Pepsi — Janhvi Singh Pataka✨",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.pacifico(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Button bottom center
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: GestureDetector(
                onTap: _handleTap,
                onDoubleTap: _handleDoubleTap,
                onLongPress: _handleLongPress,
                child: FloatingActionButton(
                  onPressed: () {},
                  backgroundColor: Colors.amber,
                  child: const Icon(
                    Icons.local_fire_department,
                    color: Colors.deepOrange,
                    size: 36,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
