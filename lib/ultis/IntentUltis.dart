import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntentUtils {
  static Function(dynamic) _callback;
  static changeScreenNomal(BuildContext context, Widget view) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => view));
  }

  static changeScreenWithResult(BuildContext context, Widget view, _callback) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => view))
        .then((value) {
      _callback(value);
    });
  }

  static backView(BuildContext context) {
    Navigator.of(context).pop();
  }
}
