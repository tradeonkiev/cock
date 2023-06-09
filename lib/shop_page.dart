// ignore_for_file: library_private_types_in_public_api, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});



  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int _clickMultiplier = 1;
  int _clickPlus = 0;
  int _clickMultiplierCost = 10;
  int _clickPlusCost = 10;
  int _clicks = 0;

  @override
  void initState() {
    super.initState();
    _loadMultiplier();
  }

  void _loadMultiplier() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _clickMultiplier = prefs.getInt('clickMultiplier') ?? 1;
      _clickPlus = prefs.getInt('clickPlus') ?? 0;
      _clickMultiplierCost = prefs.getInt('clickMultiplierCost') ?? 10;
      _clickPlusCost = prefs.getInt('clickPlusCost') ?? 10;
      _clicks = prefs.getInt('counter') ?? 0;

    });
  }

  void _save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('clickMultiplier', _clickMultiplier);
    prefs.setInt('clickPlus', _clickPlus);
    prefs.setInt('clickMultiplierCost', _clickMultiplierCost);
    prefs.setInt('clickPlusCost', _clickPlusCost);
    prefs.setInt('counter', _clicks);

  }

  void _buyClickMultiplier() {
    if (_clicks >= _clickMultiplierCost) {
      setState(() {
        _clicks -= _clickMultiplierCost;
        _clickMultiplier += 2;
        _clickMultiplierCost *= 5;
      });
      _save();
    }
  }

  void _buyClickPlus() {
    if (_clicks >= _clickPlusCost) {
      setState(() {
        _clicks -= _clickPlusCost;
        _clickPlus++;
        _clickPlusCost *= 2;
      });
      _save();
    }
  }
  void _resetCounter() {
    setState(() {
      _clicks = 0;
      _clickPlus = 0;
      _clickPlusCost = 10;
      _clickMultiplier = 1;
      _clickMultiplierCost = 10;
    });
    _save();
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        color: const Color.fromRGBO(26, 44, 51, 1.0),
        child:Column(
            children: [
              Container(
                height: 100,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(34, 63, 77, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'x$_clickMultiplier',
                      style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Закругление углов кнопки// Рамка с белым цветом
                            ),
                          ),
                          onPressed: _buyClickMultiplier,
                          child: Text('Buy x${_clickMultiplier + 2} cookie multiplier'),
                        ),
                        Text(
                          'Cost: $_clickMultiplierCost clicks',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(131, 168, 183, 1.0)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 100,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(34, 63, 77, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '+$_clickPlus',
                      style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7.5), // Закругление углов кнопки// Рамка с белым цветом
                            ),
                          ),
                          onPressed: _buyClickPlus,
                          child: Text('Buy +${_clickPlus + 1} cookie plus bonus'),
                        ),
                        Text(
                          'Cost: $_clickPlusCost clicks',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(131, 168, 183, 1.0)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(34, 63, 77, 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(34, 63, 77, 1.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: const Color.fromRGBO(34, 63, 77, 1.0),
                          titleTextStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          title: const Text('Подтверждение'),
                          content: const Text(
                              'Вы уверены, что хотите продолжить?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                          ),
                          actions: [
                            TextButton(
                              child: const Text('Нет'),
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            ),
                            TextButton(
                              child: const Text('Да'),
                              onPressed: () {
                                _resetCounter();
                                Navigator.of(context).pop(true);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child:
                  const Text(
                    "RESET SCORE",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20
                    ),
                  ),
                ),
              ),
            ],
        ),
      );
  }
}
