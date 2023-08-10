import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auction_app/feature/presentation/controller/home_page_controller.dart';
import 'package:auction_app/flutx/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';

class HomepageWidget extends StatefulWidget {
  const HomepageWidget({super.key});

  @override
  State<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget> {
  late ThemeData theme;
  late HomePageController controller;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.nftTheme;
    controller = FxControllerStore.putOrFind(HomePageController());
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder<HomePageController>(
        controller: controller,
        theme: theme,
        builder: (controller) {
          return Scaffold(
              resizeToAvoidBottomInset: false,
              body: Padding(
                padding: FxSpacing.fromLTRB(
                    20, FxSpacing.safeAreaTop(context) + 40, 20, 0),
                child: Center(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(width: 20.0, height: 100.0),
                    const Text(
                      'Be',
                      style: TextStyle(fontSize: 43.0),
                    ),
                    const SizedBox(width: 20.0, height: 100.0),
                    DefaultTextStyle(
                      style: const TextStyle(
                        fontSize: 40.0,
                        fontFamily: 'Horizon',
                      ),
                      child: AnimatedTextKit(animatedTexts: [
                        RotateAnimatedText('AWESOME'),
                        RotateAnimatedText('OPTIMISTIC'),
                        RotateAnimatedText('DIFFERENT'),
                      ]),
                    ),
                  ],
                )),
              ));
        });
  }
}

class SelectableList extends StatefulWidget {
  const SelectableList({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SelectableListState createState() => _SelectableListState();
}

class _SelectableListState extends State<SelectableList> {
  final List<int> _list = List.generate(20, (i) => i);
  final List<bool> _selected = List.generate(20, (i) => false);
  late ThemeData theme;
  bool _isSelectable = false;
  late CustomTheme customTheme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.separated(
            itemCount: _list.length,
            itemBuilder: (context, index) {
              return Ink(
                color: _selected[index]
                    ? theme.colorScheme.primary
                    : theme.colorScheme.background,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: _selected[index]
                        ? theme.colorScheme.secondary
                        : theme.colorScheme.secondary.withAlpha(240),
                    child: _selected[index]
                        ? Icon(
                            Icons.done,
                            color: theme.colorScheme.onSecondary,
                          )
                        : FxText.bodyLarge(_list[index].toString(),
                            fontWeight: 600,
                            color: _selected[index]
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onSecondary),
                  ),
                  subtitle: FxText.bodyMedium('Sub Item',
                      fontWeight: 500,
                      color: _selected[index]
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onBackground),
                  title: FxText.bodyLarge('Item - ${_list[index]}',
                      fontWeight: 600,
                      color: _selected[index]
                          ? theme.colorScheme.onPrimary
                          : theme.colorScheme.onBackground),
                  onTap: () => {
                    if (_isSelectable)
                      {
                        setState(() {
                          _selected[index] = !_selected[index];
                        })
                      },
                    if (!_selected.contains(true))
                      {
                        setState(() {
                          _isSelectable = false;
                        })
                      }
                  },
                  onLongPress: (() => setState(() => {
                        if (_isSelectable)
                          {_selected[index] = true}
                        else
                          {_isSelectable = true, _selected[index] = true}
                      })),
                ),
              );
            },
            separatorBuilder: (_, __) => Divider(
                  height: 0.5,
                  color: theme.dividerColor,
                )));
  }
}
