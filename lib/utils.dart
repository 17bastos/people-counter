import 'package:flutter/material.dart';
import 'package:peoplecounter/strings.dart';

getIcon(TargetPlatform platform) {
  switch (platform) {
    case TargetPlatform.android:
    case TargetPlatform.fuchsia:
      return const Icon(
        Icons.more_vert,
      );
    case TargetPlatform.iOS:
      return const Icon(
        Icons.more_horiz,
      );
  }
  return null;
}

alert(BuildContext context, String msg, {Function? callback}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(Strings.contador_de_pessoas),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
                if(callback != null) {
                  callback();
                }
              },
            )
          ],
        ),
      );
    },
  );
}

Map<int, Color> mapColor = {
  50:Color(0xff4adc84).withOpacity(0.1),
  100:Color(0xff4adc84).withOpacity(0.2),
  200:Color(0xff4adc84).withOpacity(0.3),
  300:Color(0xff4adc84).withOpacity(0.4),
  400:Color(0xff4adc84).withOpacity(0.5),
  500:Color(0xff4adc84).withOpacity(0.6),
  600:Color(0xff4adc84).withOpacity(0.7),
  700:Color(0xff4adc84).withOpacity(0.8),
  800:Color(0xff4adc84).withOpacity(0.9),
  900:Color(0xff4adc84).withOpacity(0.1)
};

MaterialColor primaryColor = MaterialColor(0xff4adc84, mapColor);