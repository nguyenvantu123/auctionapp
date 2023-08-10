// @dart=2.9

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:auction_app/flutx/theme/app_notifier.dart';
import 'package:auction_app/flutx/theme/app_theme.dart';
import 'package:auction_app/utils/config/base_url_config.dart';
import 'package:auction_app/utils/config/flavor_config.dart';
import 'package:provider/provider.dart';
import 'package:auction_app/injection_container.dart' as di;
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppTheme.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  FlavorConfig(
    flavor: Flavor.DEVELOPMENT,
    values: FlavorValues(baseUrl: BaseUrlConfig.baseUrlDevelopment),
  );
  await di.init();
  runApp(ChangeNotifierProvider<AppNotifier>(
    create: (context) => AppNotifier(),
    child: const MyApp(),
  ));
}
