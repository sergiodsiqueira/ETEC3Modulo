import 'package:flutter/material.dart';

alert(BuildContext context, String pTitulo, String pMsg) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text(pTitulo),
              content: Text(pMsg),
              actions: <Widget>[
                TextButton(
                    child: Text("OK"),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            ));
      });
}