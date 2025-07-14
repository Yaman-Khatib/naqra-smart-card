import 'package:flutter/material.dart';
import 'package:naqra_web/screens/cutomize_profile_screen.dart';
import 'package:naqra_web/screens/login-screens/login_screen.dart';
import 'package:naqra_web/screens/login-screens/signup_screen.dart';
import 'package:naqra_web/screens/login-screens/welcome_screen.dart';
import 'package:naqra_web/screens/view_contact_screen.dart';

class AppTheme {
  static const primaryColor = Color(0xFF000000);
  static const backgroundColor = Color(0xffC5CACC);
  static const cardColor = Colors.white;
  static const textColor = Color(0xFF333333);
  static const mutedText = Colors.grey;
  static const accentColor = Color(0xFF007AFF);

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: Color(0xFFE5E5E5),
      primaryColor: primaryColor,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: accentColor,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: textColor),
        bodyMedium: TextStyle(fontSize: 14, color: textColor),
        bodySmall: TextStyle(fontSize: 12, color: mutedText),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 14),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[200]!,
        labelStyle: const TextStyle(color: textColor),
        padding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      cardTheme: CardThemeData(
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 6),
      ),
    );
  }
}

void main() {
  print('started app');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Naqra',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: 'editProfile',
      routes: {
        'ViewProfile': (context) => ViewContactScreen(),
        'welcomeScreen': (context) => WelcomeScreen(),
        'signup': (context) => SignUpScreen(),
        'login': (context) => LoginScreen(),
        'editProfile': (context)=>EditProfileScreen(initialFName: 'Yaman', initialLName: 'AlKhatib')
        // Add more routes here when needed
      },
    );
  }
}
