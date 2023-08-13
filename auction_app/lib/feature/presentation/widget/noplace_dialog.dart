import 'package:auction_app/feature/presentation/controller/noplace_dialog_controller.dart';
import 'package:auction_app/flutx/theme/app_theme.dart';
import 'package:auction_app/flutx/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutx/flutx.dart';

class NoPlaceDialog extends StatefulWidget {
  const NoPlaceDialog({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NoPlaceDialogState createState() => _NoPlaceDialogState();
}

class _NoPlaceDialogState extends State<NoPlaceDialog> {
  late ThemeData theme;
  late CustomTheme customAppTheme;

  late NoPlaceDialogController noplaceDialogController;

  @override
  void initState() {
    super.initState();
    noplaceDialogController =
        FxControllerStore.putOrFind(NoPlaceDialogController());
    theme = AppTheme.theme;
    customAppTheme = AppTheme.customTheme;
  }

  @override
  Widget build(BuildContext context) {
    return FxBuilder(
        controller: noplaceDialogController,
        builder: (controller) {
          return Dialog(
            insetPadding: FxSpacing.x(16),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: Container(
              padding: FxSpacing.xy(16, 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FxSpacing.height(24),
                  FxContainer.bordered(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    paddingAll: 0,
                    border: Border.all(color: customAppTheme.card, width: 1),
                    child: Column(
                      children: [
                        Divider(
                          height: 0,
                          thickness: 0.9,
                          color: customAppTheme.border,
                        ),
                      ],
                    ),
                  ),
                  FxSpacing.height(24),
                  FxButton(
                      borderRadiusAll: 4,
                      elevation: 0,
                      onPressed: () {
                        noplaceDialogController.confirm();
                      },
                      backgroundColor: customAppTheme.homemadePrimary,
                      child: FxText(
                        "Confirm",
                        color: customAppTheme.homemadeOnPrimary,
                      ))
                ],
              ),
            ),
          );
        });
  }
}
