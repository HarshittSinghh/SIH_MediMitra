import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pie_chart/pie_chart.dart' as pie_chart;
import 'package:pie_chart/pie_chart.dart';

void main() {
  runApp(const Chart());
}

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    PieChartScreen(),
    LineChartScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart),
                label: 'Disease Spread',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.show_chart),
                label: 'Statewise Data',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.white,
            backgroundColor: Colors.deepPurple,
            unselectedItemColor: Colors.grey,
            onTap: _onItemTapped,
          ),
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),
    );
  }
}

class PieChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Malaria": 18.47,
      "Dengue": 17.70,
      "Tuberculosis": 4.25,
      "Cholera": 3.51,
      "Other": 2.83,
    };

    List<Color> colorList = [
      const Color(0xffD95AF3),
      const Color(0xff3EE094),
      const Color(0xff3398F6),
      const Color(0xffFA4A42),
      const Color(0xffFE9539)
    ];

    final gradientList = <List<Color>>[
      [
        Color.fromRGBO(223, 250, 92, 1),
        Color.fromRGBO(129, 250, 112, 1),
      ],
      [
        Color.fromRGBO(129, 182, 205, 1),
        Color.fromRGBO(91, 253, 199, 1),
      ],
      [
        Color.fromRGBO(175, 63, 62, 1.0),
        Color.fromRGBO(254, 154, 92, 1),
      ]
    ];

    return Center(
      child: pie_chart.PieChart(
        dataMap: dataMap,
        colorList: colorList,
        chartRadius: MediaQuery.of(context).size.width / 2,
        centerText: "Health Issues",
        ringStrokeWidth: 24,
        animationDuration: const Duration(seconds: 3),
        chartValuesOptions: const ChartValuesOptions(
            showChartValues: true,
            showChartValuesOutside: true,
            showChartValuesInPercentage: true,
            showChartValueBackground: false),
        legendOptions: const LegendOptions(
            showLegends: true,
            legendShape: BoxShape.rectangle,
            legendTextStyle: TextStyle(fontSize: 15),
            legendPosition: LegendPosition.bottom,
            showLegendsInRow: true),
        gradientList: gradientList,
      ),
    );
  }
}

class LineChartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<FlSpot> leftData = [
      const FlSpot(0, 5),  // Bihar
      const FlSpot(1, 10), // Uttar Pradesh
      const FlSpot(2, 15), // Madhya Pradesh
      const FlSpot(3, 20), // Rajasthan
    ];

    List<FlSpot> rightData = [
      const FlSpot(0, 100), // Maharashtra
      const FlSpot(1, 150), // Gujarat
      const FlSpot(2, 250), // Karnataka
      const FlSpot(3, 300), // Tamil Nadu
    ];

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            gridData: const FlGridData(show: true),
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                axisNameWidget: const Text("States"),
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    switch (value.toInt()) {
                      case 0:
                        return const Text('Bihar');
                      case 1:
                        return const Text('U.P.');
                      case 2:
                        return const Text('M.P.');
                      case 3:
                        return const Text('Raj.');
                      default:
                        return const Text('');
                    }
                  },
                ),
              ),
              leftTitles: AxisTitles(
                axisNameWidget: const Text("Cases (thousands)"),
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Text(value.toInt().toString());
                  },
                ),
              ),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d), width: 1),
            ),
            minX: 0,
            maxX: 3,
            minY: 0,
            maxY: 350,
            lineBarsData: [
              LineChartBarData(
                spots: leftData,
                isCurved: true,
                color: Colors.blue,
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(show: false),
              ),
              LineChartBarData(
                spots: rightData,
                isCurved: true,
                color: Colors.red,
                dotData: FlDotData(show: true),
                belowBarData: BarAreaData(show: false),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
