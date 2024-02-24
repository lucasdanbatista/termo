import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isLoading = true;
  final backgroundColor = const Color(0xFF6E5C62);
  late final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(backgroundColor)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (progress) {
          if (progress == 100) {
            setState(() => isLoading = false);
          }
        },
      ),
    );

  @override
  void initState() {
    super.initState();
    controller.loadRequest(Uri.https('term.ooo'));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: backgroundColor,
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: Colors.white,
        ),
      ),
      home: Scaffold(
        body: Visibility(
          visible: isLoading,
          replacement: SafeArea(
            child: WebViewWidget(
              controller: controller,
            ),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
