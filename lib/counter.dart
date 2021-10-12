import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:peoplecounter/main.dart';
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
  bool _isThemeLight = true;

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

  _setTheme() {
    setState(() {
      _isThemeLight = !_isThemeLight;
      Prefs.setBool('theme', _isThemeLight);
      isLightTheme.add(_isThemeLight);
    });
  }

  _getThemeFromPrefs() async {
    bool? isThemeLight = await Prefs.getBool('theme');
    print(isThemeLight);

    if (isThemeLight == null) {
      _selectTheme();
    } else {
      _isThemeLight = isThemeLight;
      isLightTheme.add(_isThemeLight);
    }
  }

  _selectTheme() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(Strings.selecione_um_tema),
            content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 100,
                      child: Image.asset("assets/images/tema_claro.jpeg")),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      width: 100,
                      child: Image.asset("assets/images/tema_escuro.jpeg")),
                ]),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Prefs.setBool('theme', true);
                      Navigator.pop(context);
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: 100,
                        child: Text(
                          Strings.tema_claro,
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  SizedBox(width: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black87),
                    onPressed: () {
                      Prefs.setBool('theme', false);
                      _setTheme();
                      Navigator.pop(context);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 100,
                      child: Text(Strings.tema_escuro,
                          style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              )
            ],
          );
        });
  }

  @override
  void initState() {
    _getThemeFromPrefs();
    _getCounterFromPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? "",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          PopupMenuButton<int>(
            icon: getIcon(Theme.of(context).platform),
            onSelected: (selection) {
              switch (selection) {
                case 0:
                  _clearCounter();
                  break;
                case 1:
                  _setTheme();
                  break;
                case 2:
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: 5,
                    ),
                    Text(_isThemeLight
                        ? Strings.tema_escuro
                        : Strings.tema_claro),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 2,
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
