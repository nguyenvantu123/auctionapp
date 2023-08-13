import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class DialogSuccessWidget extends StatefulWidget {
  final String message;

  final String header;

  final String footer;

  const DialogSuccessWidget({
    super.key,
    required this.message,
    required this.header,
    required this.footer,
  });

  @override
  State<DialogSuccessWidget> createState() => _DialogSuccessWidgetState();
}

class _DialogSuccessWidgetState extends State<DialogSuccessWidget>
    with TickerProviderStateMixin {
  bool isInProgress = true;
  late Timer _timer;

  bool isSizeTransition = true;

  // late CustomTheme customTheme;
  // late ThemeData theme;
  late String message;
  late String header;
  late String footer;

  late AnimationController scaleController = AnimationController(
      duration: const Duration(milliseconds: 800), vsync: this);
  late Animation<double> scaleAnimation =
      CurvedAnimation(parent: scaleController, curve: Curves.elasticOut);
  late AnimationController checkController = AnimationController(
      duration: const Duration(milliseconds: 600), vsync: this);
  late Animation<double> checkAnimation =
      CurvedAnimation(parent: checkController, curve: Curves.linear);

  @override
  void initState() {
    super.initState();
    // customTheme = AppTheme.customTheme;
    // theme = AppTheme.theme;

    message = widget.message;
    header = widget.header;
    footer = widget.footer;
    startTimer();
  }

  void startTimer() {
    setState(() {
      isInProgress = true;
    });
    const oneSec = const Duration(seconds: 2);
    _timer = Timer.periodic(
        oneSec,
        (Timer timer) => {
              _timer.cancel(),
              setState(
                () {
                  isInProgress = false;
                  scaleController.addStatusListener((status) {
                    if (status == AnimationStatus.completed) {
                      checkController.forward();
                    }
                  });

                  scaleController.forward();

                  _timer = Timer.periodic(
                      oneSec,
                      (Timer timer) => {
                            _timer.cancel(),
                            setState(() {
                              isSizeTransition = false;
                            })
                          });
                },
              )
            });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();

    scaleController.dispose();
    checkController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    double circleSize = 70;
    double iconSize = 60;

    return isInProgress
            ? AnimatedCrossFade(
                firstChild: HeaderDialogue(),
                secondChild: IconDialogue(
                    scaleAnimation: scaleAnimation,
                    circleSize: circleSize,
                    checkAnimation: checkAnimation,
                    iconSize: iconSize),
                crossFadeState: isInProgress
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                // firstCurve: Curves.easeIn,
                // secondCurve: Curves.easeInOut,
                // sizeCurve: Curves.bounceOut,
                duration: const Duration(milliseconds: 1000),
                layoutBuilder: layoutBuilderWidget,
              )
            : AnimatedCrossFade(
                firstChild: IconDialogue(
                    scaleAnimation: scaleAnimation,
                    circleSize: circleSize,
                    checkAnimation: checkAnimation,
                    iconSize: iconSize),
                secondChild: ContentDialogue(
                    theme: theme,
                    header: header,
                    message: message,
                    footer: footer),
                // firstCurve: Curves.easeIn,
                // secondCurve: Curves.easeInOut,
                // sizeCurve: Curves.bounceOut,
                crossFadeState: isSizeTransition
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 1000),
                layoutBuilder: layoutBuilderWidget,
              )
        // : (isSizeTransition
        //     ? IconDialogue(
        //         scaleAnimation: scaleAnimation,
        //         circleSize: circleSize,
        //         checkAnimation: checkAnimation,
        //         iconSize: iconSize)
        //     : ContentDialogue(
        //         theme: theme,
        //         header: header,
        //         message: message,
        //         footer: footer))
        ;
  }

  Widget layoutBuilderWidget(
      topChild, topChildKey, bottomChild, bottomChildKey) {
    return Stack(
      children: [
        Positioned(
          left: 0.0,
          right: 0.0,
          top: 0.0,
          bottom: 0.0,
          key: bottomChildKey,
          child: bottomChild,
        ),
        Positioned(
          key: topChildKey,
          child: topChild,
        )
      ],
    );
  }

  //   return isInProgress
  //       ? HeaderDialogue()
  //       : (isSizeTransition
  //           // ? CheckAnimation(
  //           //     size: 100,
  //           //     onComplete: () {
  //           //       return;
  //           //     },
  //           //   )
  //           ? IconDialogue(
  //               scaleAnimation: scaleAnimation,
  //               circleSize: circleSize,
  //               checkAnimation: checkAnimation,
  //               iconSize: iconSize)
  //           : ContentDialogue(
  //               theme: theme,
  //               header: header,
  //               message: message,
  //               footer: footer));
  // }
}

class ContentDialogue extends StatelessWidget {
  const ContentDialogue({
    super.key,
    required this.theme,
    required this.header,
    required this.message,
    required this.footer,
  });

  final ThemeData theme;
  final String header;
  final String message;
  final String footer;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.only(top: 16, bottom: 16, left: 24, right: 24),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Center(
                  child: Icon(
                Icons.check_circle_outline_rounded,
                size: 40,
                color: Colors.green,
              )),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(child: FxText.titleMedium(header, fontWeight: 700)),
            ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                  child: FxText.bodySmall(message,
                      fontWeight: 600, letterSpacing: 0)),
            ),
            // Container(
            //   margin: EdgeInsets.only(top: 16),
            //   child: Center(
            //       child: FxText.bodySmall(
            //     "Please check your inbox, a code is sent on your email as well as your mobile no.",
            //     fontWeight: 500,
            //     height: 1.15,
            //     textAlign: TextAlign.center,
            //   )),
            // ),
            Container(
              margin: EdgeInsets.only(top: 16),
              child: Center(
                child: FxButton(
                    elevation: 2,
                    borderRadiusAll: 4,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: FxText.bodySmall(footer,
                        fontWeight: 600,
                        letterSpacing: 0.3,
                        color: theme.colorScheme.onPrimary)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class IconDialogue extends StatelessWidget {
  const IconDialogue({
    super.key,
    required this.scaleAnimation,
    required this.circleSize,
    required this.checkAnimation,
    required this.iconSize,
  });

  final Animation<double> scaleAnimation;
  final double circleSize;
  final Animation<double> checkAnimation;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: ScaleTransition(
              scale: scaleAnimation,
              child: Container(
                height: circleSize,
                width: circleSize,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          SizeTransition(
            sizeFactor: checkAnimation,
            axis: Axis.horizontal,
            axisAlignment: -1,
            child: Center(
              child: Icon(Icons.check, color: Colors.white, size: iconSize),
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderDialogue extends StatelessWidget {
  const HeaderDialogue({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: SizedBox(
          width: 100,
          height: 100,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
