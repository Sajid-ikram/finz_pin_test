import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late InAppWebViewController _controller;


  InAppWebView _buildWebview() {
    return InAppWebView(
      initialFile: 'assets/pin_dev.html',
      initialSettings: InAppWebViewSettings(
        javaScriptEnabled: true,
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        useShouldOverrideUrlLoading: true,
        useHybridComposition: true,
      ),
      onWebViewCreated: (controller) {
        _controller = controller;
      },
      onProgressChanged: (controller, progress) {
        log('progress: $progress ---------------------------------------');
        if (progress == 100) {
          // Page fully loaded
        }
      },
      onReceivedError: (controller, request, error) {
        log('error: $error ---------------------------------------');
      },
      onConsoleMessage: (controller, consoleMessage) {
        final message = consoleMessage.message;
        log('message: $message');
        if (message.startsWith('token:')) {
          log('message: $message ++++++++++++++++++++++++');
        }
      },
      onReceivedServerTrustAuthRequest: (controller, challenge) async {
        return ServerTrustAuthResponse(
          action: ServerTrustAuthResponseAction.PROCEED,
        );
      },
    );
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Enter your PIN', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: _buildWebview(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 20),
              ),
              onPressed: (){

              },
              child: Text('Submit', style: TextStyle(color: Colors.white),),
            )

          ],
        ),
      ),
    );
  }
}
