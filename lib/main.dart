import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'settings.dart';
import 'model/counter.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MySettings()),
          ChangeNotifierProvider(create: (_) => Counter()),
        ],
        child: const MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter multiProvider ',
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: context.watch<MySettings>().isDark
            ? Brightness.dark
            : Brightness.light,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter MultiProvider'),
        actions: [
          Switch(
            value: context.watch<MySettings>().isDark,
            onChanged: (newValue) {
              Provider.of<MySettings>(context, listen: false)
                  .setBrightness(newValue);
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              context.watch<Counter>().myValue.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<Counter>().add();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

/*
  // Nhà cung cấp
    class YourProvider extends ChangeNotifier
    notifyListeners();
  --------------------------------------------------
  // Nhà phân phối
    ChangNotifierProvider
    MultiProvider
  --------------------------------------------------
  // Người sử dụng
    Consumer<YourProvider>
    context.watch<YourProvider>()
    context.read<YourProvider>()
  --------------------------------------------------
*/