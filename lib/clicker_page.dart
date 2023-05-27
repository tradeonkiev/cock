// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:confetti/confetti.dart';

import 'shop_page.dart';

class ClickerPage extends StatefulWidget {
  const ClickerPage({super.key});

  @override
  _ClickerPageState createState() => _ClickerPageState();
}

class _ClickerPageState extends State<ClickerPage> {
  final controller = ConfettiController();
  bool _toggle = false;
  int _counter = 0;
  int _clickMultiplier = 1;
  int _clickMultiplierCost = 10;
  int _clickPlusCost= 10;
  int _clickPlus = 0;

  @override
  void initState() {
    _load();
    super.initState();
  }

  void _load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _clickMultiplier = prefs.getInt('clickMultiplier') ?? 1;
      _clickMultiplierCost = prefs.getInt('clickMultiplierCost') ?? 10;
      _counter = prefs.getInt('counter') ?? 0;
      _clickPlus = prefs.getInt('clickPlus') ?? 0;
      _clickPlusCost = prefs.getInt('clickPlusCost') ?? 10;
    });
  }

  void _save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('clickMultiplier', _clickMultiplier);
    prefs.setInt('clickPlusCost', _clickPlusCost);
    prefs.setInt('clickMultiplierCost', _clickMultiplierCost);
    prefs.setInt('counter', _counter);
  }

  void _incrementCounter() {
    setState(() {
      _counter += (1 + _clickPlus) * _clickMultiplier;
      _toggle = !_toggle;
    });
    _save();
    controller.play();


  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
      _clickPlus = 0;
      _clickPlusCost = 10;
      _clickMultiplier = 1;
      _clickMultiplierCost = 10;
    });
    _save();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(26, 44, 51, 1.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'cookies:',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          Text(
            '$_counter',
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          GestureDetector(
            onTap: _incrementCounter,
            child: Center(
              child: Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      child:
                      ConfettiWidget(
                        confettiController: controller,
                        shouldLoop: false,
                        blastDirectionality: BlastDirectionality.explosive ,
                        emissionFrequency: 0.00005,
                        numberOfParticles: 10,
                        colors: const [
                          Color.fromRGBO(204, 158, 93, 1),
                          Color.fromRGBO(114, 69, 51, 1),
                          Color.fromRGBO(251, 194, 144, 1),
                        ],
                      ),
                    ),
                    Image(image: AssetImage('lib/assets/pngegg.png'))
                        .animate(target: _toggle ? 1 : 0)
                        .shakeX(hz: 25, curve: Curves.easeIn),
                  ],
                ),
              ),
              ),
            ),
          Text(
            '${(1 + _clickPlus) * _clickMultiplier} coockies per click',
            style: const TextStyle(
                fontSize: 24,
                color: Color.fromRGBO(131, 168, 183, 1.0)
            ),
          ),
        ],
      ),
    );
  }
}
