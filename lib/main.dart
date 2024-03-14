import 'package:flutter/material.dart';
import 'package:imin_printer/column_maker.dart';
import 'package:imin_printer/enums.dart';
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
    await iminPrinter.initPrinter().then((value) {
      print('init ${value.toString()}');
    }); // must init the printer first. for more exmaple.. pls refer to example tab.

    await iminPrinter.getPrinterStatus().then((value) {
      print(value.toString());
    });
  }

  Future printImin() async {
    await iminPrinter.printQrCode('https://www.imin.sg');

    await iminPrinter.printText('สวัสดีครับ IMIN',
        style: IminTextStyle(wordWrap: true));
    await iminPrinter.printColumnsText(cols: [
      ColumnMaker(
          text: '1', width: 1, fontSize: 26, align: IminPrintAlign.center),
      ColumnMaker(
          text: 'iMin', width: 2, fontSize: 26, align: IminPrintAlign.left),
      ColumnMaker(
          text: 'iMin', width: 1, fontSize: 26, align: IminPrintAlign.right)
    ]);

    await iminPrinter.printAndFeedPaper(100);
    await iminPrinter.partialCut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: ElevatedButton(
              onPressed: printImin, child: Text('สวัสดีครับ IMIN'))),
    );
  }
}
