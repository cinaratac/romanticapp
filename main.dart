import 'package:flutter/material.dart';
import 'dart:math'; // en üste ekle
import 'dart:async';
import 'package:flutter/services.dart';

final List<Color> renkler = [
  Colors.pink.shade50,
  Colors.pink.shade100,
  Colors.red.shade50,
  Colors.red.shade100,
  Colors.purple.shade50,
  Colors.orange.shade50,
  Colors.amber.shade50,
  const Color.fromARGB(255, 229, 192, 137),
  const Color.fromARGB(255, 223, 214, 139),
  Color.fromARGB(255, 170, 120, 180),
  const Color.fromARGB(255, 224, 125, 125),
  const Color.fromARGB(255, 140, 222, 214),
  const Color.fromARGB(255, 139, 196, 223),
];
double _kalpScale = 1.0;
Timer? _buyutmeTimer;
Color _arkaPlanRengi = Colors.pink.shade50;
final Random _random = Random();

void main() {
  runApp(NedenSeniSeviyorumApp());
}

class NedenSeniSeviyorumApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kalpli Sevgi',
      theme: ThemeData(primarySwatch: Colors.pink, fontFamily: 'Arial'),
      home: KalpliEkran(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class KalpliEkran extends StatefulWidget {
  @override
  _KalpliEkranState createState() => _KalpliEkranState();
}

class _KalpliEkranState extends State<KalpliEkran> {
  final List<String> nedenler = [
    'Bir konuda düşüncemi anlatırken beni dinleme şeklini seviyorum 💬',
    'Gece uyumadan önce konuştuğum son kişi sabah kalktığımda ilk kişi olmanı seviyorum 🌙',
    'Bakışlarımı sevmeni seviyorum 👀',
    'Makyaj yaparken seni izlemeyi seviyorum 💄',
    'Parfümlere ilgili olmanı seviyorum 🌸',
    'Bir şeylerden çıkarım yapma şeklini seviyorum 🧠',
    'Bir şeyleri tatlı bulduğun halini seviyorum 🍬',
    'Beni çok iyi tanımanı seviyorum 💗',
    'Benim bilmediğim şeyleri bilmeni seviyorum 📚',
    'Düşüncelerini söyleme biçimini ve inanılmaz objektif olmanı seviyorum 💬',
    'Duygusal olarak benden olgun olup  bana fikir verdiğin zamanları seviyorum 🫂',
    'Vücudunu tüm bedenini ayak tırmağından uzun dişine kaşındaki benden gereksiz ince yüzük parmağını seviyorum 💞',
    'İ leri yazma şeklini seviyorum 🌸',
  ];

  int _index = 0;
  bool _kalpAnim = false;
  int _sonRenkIndex = -1;

  void _sonrakiniGoster() {
    setState(() {
      _index = (_index + 1) % nedenler.length;

      int yeniIndex;
      do {
        yeniIndex = _random.nextInt(renkler.length);
      } while (yeniIndex == _sonRenkIndex);

      _sonRenkIndex = yeniIndex;
      _arkaPlanRengi = renkler[yeniIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _arkaPlanRengi,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Melisam...',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                _sonrakiniGoster();
              },
              onTapDown: (_) {
                _buyutmeTimer?.cancel();
                _buyutmeTimer = Timer.periodic(Duration(milliseconds: 50), (
                  timer,
                ) {
                  setState(() {
                    _kalpScale += 0.05;
                    if (_kalpScale > 2) _kalpScale = 2; // maksimum büyüklük
                  });
                });
                HapticFeedback.lightImpact();
              },
              onTapUp: (_) {
                _buyutmeTimer?.cancel();
                setState(() {
                  _kalpScale = 1.0;
                });
              },
              onTapCancel: () {
                _buyutmeTimer?.cancel();
                setState(() {
                  _kalpScale = 1.0;
                });
              },
              child: AnimatedScale(
                scale: _kalpScale,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOutBack,
                child: Icon(Icons.favorite, color: Colors.pink, size: 100),
              ),
            ),
            SizedBox(height: 30),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Text(
                nedenler[_index],
                key: ValueKey(_index),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
