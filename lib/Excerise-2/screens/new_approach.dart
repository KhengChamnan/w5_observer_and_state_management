import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w5_observer_pattern_and_state_management/Excerise-2/providers/model_counter.dart';

enum CardType { red, blue }

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    print("Rebuilding Home");
    return Scaffold(
      body: _currentIndex == 0 ? ColorTapsScreen() : StatisticsScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.tap_and_play),
            label: 'Taps',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Statistics',
          ),
        ],
      ),
    );
  }
}

class ColorTapsScreen extends StatefulWidget {
  const ColorTapsScreen({super.key});

  @override
  ColorTapsScreenState createState() => ColorTapsScreenState();
}

class ColorTapsScreenState extends State<ColorTapsScreen> {
  @override
  Widget build(BuildContext context) {
    print("Rebuilding ColorTapsScreen");
    return Scaffold(
      appBar: AppBar(title: Text('Color Taps')),
      body: Column(
        children: [ColorTap(type: CardType.red), ColorTap(type: CardType.blue)],
      ),
    );
  }
}

class ColorTap extends StatelessWidget {
  final CardType type;

  const ColorTap({super.key, required this.type});

  Color get backgroundColor => type == CardType.red ? Colors.red : Colors.blue;

  @override
  Widget build(BuildContext context) {
    print("Rebuilding ColorTap ${type.toString()}");
    return Consumer<ColorCounters>(
      builder: (BuildContext context,counter,Widget? child) {
        print("Rebuilding Consumer in ColorTap ${type.toString()}");
        return GestureDetector(
      onTap: () {
        if (type == CardType.red) {
          counter.incrementRedCount();
        } else {
          counter.incrementBlueCount();
        }
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        height: 100,
        child: Center(
          child: Text(
            'Taps: ${type == CardType.red ? counter.redCount : counter.blueCount}',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    ); 
      }
    );
  }
}

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print("Rebuilding StatisticsScreen");
    return Scaffold(
      appBar: AppBar(title: Text('Statistics')),
      body: Center(
        child: Consumer<ColorCounters>(
          builder: (context, value, child) {
            print("Rebuilding Consumer in StatisticsScreen");
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Red Taps: ${value.redCount}', style: TextStyle(fontSize: 24)),
                Text('Blue Taps: ${value.blueCount}', style: TextStyle(fontSize: 24)),
              ],
            );
          }
        ),
      ),
    );
  }
}
