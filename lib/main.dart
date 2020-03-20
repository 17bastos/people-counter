import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:peoplecounter/prefs.dart';
import 'package:peoplecounter/strings.dart';
import 'package:peoplecounter/utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.contador_de_pessoas,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: Strings.contador_de_pessoas),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _getCounterFromPrefs();
  }

  _getCounterFromPrefs() async {
    _counter = await Prefs.getInt("counter");
    setState(() {});
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
      Prefs.setInt("counter", _counter);
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter = _counter - 1 < 0 ? 0 : _counter - 1;
      Prefs.setInt("counter", _counter);
    });
  }


  void _clearCounter() {
    setState(() {
      _counter = 0;
      Prefs.setInt("counter", _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<int>(
            icon: getIcon(Theme.of(context).platform),
            onSelected: (selection) {
              switch (selection) {
                case 0:
                  _clearCounter();
                  break;
                case 1:
                  alert(context, Strings.descricao_sobre);
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 5,
                    ),
                    Text(Strings.zerar_contador),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      width: 5,
                    ),
                    Text(Strings.sobre),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Strings.quantidade_de_pessoas_dentro,
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '$_counter',
              style: TextStyle(fontSize: 100),
            ),
            SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Transform.scale(
                  scale: 1.5,
                  child: FloatingActionButton(
                    key: Key("add"),
                    onPressed: _decrementCounter,
                    backgroundColor: Colors.red,
                    tooltip: Strings.menos_uma_pessoa,
                    child: Icon(Icons.remove),
                  ),
                ),
                SizedBox(
                  width: 80,
                ),
                Transform.scale(
                  scale: 1.5,
                  child: FloatingActionButton(
                    key: Key("remove"),
                    onPressed: _incrementCounter,
                    tooltip: Strings.mais_uma_pessoa,
                    backgroundColor: Colors.green,
                    child: Icon(Icons.add),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
