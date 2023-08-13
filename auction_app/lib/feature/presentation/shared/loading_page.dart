import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Platform.isIOS
              ? CupertinoActivityIndicator()
              : CircularProgressIndicator(),
        ),
      ),
    );
  }
}
