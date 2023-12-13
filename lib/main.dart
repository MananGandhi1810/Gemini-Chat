import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'presentation/home_page.dart';
import 'providers/chat_context_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const RootApp());
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatContextProvider>(
          create: (context) => ChatContextProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Gemini Chat',
        theme: ThemeData(
          primarySwatch : Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}