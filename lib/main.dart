import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ContainerConfigProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Container Configurator'),
        ),
        body: Column(
          children: [
            Expanded(flex: 3, child: ConfigurableContainer()), // Віджет контейнера
            Expanded(flex: 2, child: SliderSection()),         // Віджет секції слайдерів
          ],
        ),
      ),
    );
  }
}

// ======== PROVIDER ========
class ContainerConfigProvider extends ChangeNotifier {
  double _width = 100;
  double _height = 100;
  double _borderRadius = 0;

  double get width => _width;
  double get height => _height;
  double get borderRadius => _borderRadius;

  void setWidth(double newWidth) {
    _width = newWidth;
    notifyListeners();
  }

  void setHeight(double newHeight) {
    _height = newHeight;
    notifyListeners();
  }

  void setBorderRadius(double newRadius) {
    _borderRadius = newRadius;
    notifyListeners();
  }
}

// ======== CUSTOM WIDGETS ========

// Віджет контейнера
class ConfigurableContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ContainerConfigProvider>(context);
    return Center(
      child: Container(
        width: config.width,
        height: config.height,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(config.borderRadius),
          ),
        ),
      ),
    );
  }
}

// Секція слайдерів
class SliderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final config = Provider.of<ContainerConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text('Width: ${config.width.toInt()}'),
          Slider(
            value: config.width,
            min: 50,
            max: 300,
            divisions: 50,
            label: config.width.toInt().toString(),
            onChanged: (value) {
              config.setWidth(value);
            },
          ),
          Text('Height: ${config.height.toInt()}'),
          Slider(
            value: config.height,
            min: 50,
            max: 300,
            divisions: 50,
            label: config.height.toInt().toString(),
            onChanged: (value) {
              config.setHeight(value);
            },
          ),
          Text('Top Right Radius: ${config.borderRadius.toInt()}'),
          Slider(
            value: config.borderRadius,
            min: 0,
            max: 150,
            divisions: 50,
            label: config.borderRadius.toInt().toString(),
            onChanged: (value) {
              config.setBorderRadius(value);
            },
          ),
        ],
      ),
    );
  }
}
