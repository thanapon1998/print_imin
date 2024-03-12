import 'package:flutter/material.dart';
import 'package:imin_printer/imin_printer.dart';
import 'package:imin_printer/imin_style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Print Imin'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  IminPrinter iminPrinter = IminPrinter();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPrint();
  }

  Future initPrint() async {
    // all method from imin printer need to async await
    await iminPrinter
        .initPrinter(); // must init the printer first. for more exmaple.. pls refer to example tab.

    await iminPrinter.getPrinterStatus();
  }

  Future printImin() async {
    await iminPrinter.printText('print example',
        style: IminTextStyle(wordWrap: true));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child:
              ElevatedButton(onPressed: printImin, child: Text('Print IMIN'))),
    );
  }
}
