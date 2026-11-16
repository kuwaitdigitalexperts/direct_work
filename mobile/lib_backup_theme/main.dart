import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/localization/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'providers/locale_provider.dart';
import 'routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProviderScope(
      child: DirectJobKuwaitApp(),
    ),
  );
}

class DirectJobKuwaitApp extends ConsumerWidget {
  const DirectJobKuwaitApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'Direct work | دايركت وورك الكويت',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
      locale: currentLocale,
      supportedLocales: const [
        Locale('ar', 'KW'),
        Locale('ar'),
        Locale('en', 'US'),
        Locale('en'),
        Locale('ur'),
        Locale('hi'),
        Locale('bn'),
        Locale('tl'),
        Locale('fil'),
        Locale('ml'),
        Locale('te'),
        Locale('ta'),
      ],
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
