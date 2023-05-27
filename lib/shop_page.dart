import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopPage extends StatefulWidget {


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
        _clickMultiplier++;
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

  void _goBack() {
    Navigator.pop(context, _clicks);
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        color: Color.fromRGBO(26, 44, 51, 1.0),
        child:Column(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(color: Color.fromRGBO(34, 63, 77, 1.0), borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'x$_clickMultiplier',
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _buyClickMultiplier,
                          child: Text('Buy Click Multiplier (+$_clickMultiplier)'),
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
              SizedBox(height: 10),
              Container(
                height: 100,
                decoration: BoxDecoration(color: Color.fromRGBO(34, 63, 77, 1.0), borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      '+$_clickPlus',
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _buyClickPlus,
                          child: Text('Buy Click Multiplier (+${_clickPlus + 1})'),
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
                height: 100,
                decoration: const BoxDecoration(color: Color.fromRGBO(34, 63, 77, 1.0), borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'x$_clickMultiplier',
                      style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _buyClickMultiplier,
                          child: Text('Buy Click Multiplier (+$_clickMultiplier)'),
                        ),
                        Text(
                          'Cost: $_clickMultiplierCost clicks',
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(131, 168, 183, 1.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
        ),
      );
  }
}
