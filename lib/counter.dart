import 'package:flutter/material.dart';
import 'package:peoplecounter/prefs.dart';
import 'package:peoplecounter/strings.dart';
import 'package:peoplecounter/utils.dart';

class Counter extends StatefulWidget {
  const Counter({Key? key, this.title}) : super(key: key);

  final String? title;


  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {


  int _counter = 0;

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
  void initState() {
    _getCounterFromPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ""),
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
            ),
          ],
        ),
      ),
    );
  }
}
