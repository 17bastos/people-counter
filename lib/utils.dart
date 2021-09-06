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
