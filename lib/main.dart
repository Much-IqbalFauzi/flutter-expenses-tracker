import 'package:expenzes_tracker/widget/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.cyanAccent);

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blueGrey.shade900,
  primaryContainer: Colors.blueGrey.shade900,
  brightness: Brightness.dark,
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([]).then(
    (value) {
      runApp(
        MaterialApp(
          // darkTheme: ThemeData.dark(),
          theme: ThemeData(
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: kDarkColorScheme.primaryContainer,
            ),
            cardTheme: const CardTheme().copyWith(
              color: Colors.blueGrey.shade900,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade200,
                  foregroundColor: Colors.black54),
            ),
            textTheme: ThemeData().textTheme.copyWith(
                  titleLarge: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white54,
                  ),
                  titleMedium: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.white54,
                  ),
                  titleSmall: const TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.white70,
                  ),
                ),
          ).copyWith(colorScheme: kDarkColorScheme),
          // themeMode: ThemeMode.dark,
          home: const Expenses(),
        ),
      );
    },
  );
}
