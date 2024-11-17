import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'pages/start_page.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/chat_bot_page.dart';
import 'pages/after_register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'pages/profile_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Initialize Firebase with error handling
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Add specific error handling for Google APIs
    try {
      await dotenv.load(fileName: ".env");
      debugPrint("ENV loaded successfully");
    } catch (e) {
      debugPrint("Warning: .env file not found or invalid. Using default configuration.");
    }
  } catch (e) {
    debugPrint("Error initializing Firebase: $e");
    // You might want to show an error dialog here
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PureLife',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        // Add error handling for the entire app
        ErrorWidget.builder = (FlutterErrorDetails details) {
          return Material(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Text(
                'An error occurred: ${details.exception}',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          );
        };
        return child ?? const SizedBox.shrink();
      },
      initialRoute: '/',
      routes: {
        '/': (context) => const StartPageWidget(),
        '/login': (context) => const LoginPageWidget(),
        '/register': (context) => const RegisterPageWidget(),
        '/after_register': (context) => const AfterRegisterWidget(),
        '/home': (context) => const HomePageWidget(),
        '/profile': (context) => const ProfilePage(),
        '/chatbot': (context) => const ChatBotPage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => const Scaffold(
          body: Center(child: Text('Route not found')),
        ),
      ),
    );
  }
}
