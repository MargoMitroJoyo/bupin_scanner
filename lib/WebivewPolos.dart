import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HalamanWebview extends StatefulWidget {
  final String url;
  final String judul;

  const HalamanWebview({Key? key, required this.url, required this.judul})
      : super(key: key);

  @override
  State<HalamanWebview> createState() => _HalamanWebviewState();
}

class _HalamanWebviewState extends State<HalamanWebview>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );
  late final AnimationController _controller2 = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation2 = CurvedAnimation(
    parent: _controller2,
    curve: Curves.easeIn,
  );
  late final WebViewController controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(
        Color.fromRGBO(70, 89, 166, 1),
      )
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (NavigationRequest request) async {
          if (request.url.startsWith('https://chat.whatsapp.com/') ||
              request.url.startsWith('https://t.me/') ||
              request.url.startsWith('https://www.instagram.com/') ||
              request.url.startsWith('https://s.bupin.id/')) {
            await _launchInBrowser(Uri.parse(request.url));
            print('allowing navigation to $request');
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        },
        onProgress: (int progress) {
          setState(() {
            _isLoading = progress < 100;
          });
        },
        onPageStarted: (String url) {
          setState(() {
            _isLoading = true;
          });
        },
        onPageFinished: (String url) {
          setState(() {
            _isLoading = false;
          });
          _controller2.animateBack(0);
          _controller.forward();
        },
        onWebResourceError: (e) {
          setState(() {
            _isLoading = false;
          });
        },
      ))
      ..loadRequest(
        Uri.parse(widget.url),
      );
    controller.setBackgroundColor(Colors.white);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const Text('Yakin akan keluar ?'),
          content: const Text(
            'Pastikan data anda sudah tersimpan sebelum keluar.',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text(
                'Ya',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Tidak', style: TextStyle(color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    log("Soal");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(15.0),
          child: GestureDetector(
              onTap: () {
                _dialogBuilder(context);
              },
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Center(
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 15,
                    weight: 100,
                  ),
                ),
              )),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.judul,
          style: const TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).primaryColor,
              ),
              minHeight: 3,
              value: _isLoading ? null : 0,
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  FadeTransition(
                    opacity: _animation,
                    child: WebViewWidget(controller: controller),
                  ),
                  FadeTransition(
                    opacity: _animation2,
                    child: Image.asset(
                      "asset/logo.png",
                      width: MediaQuery.of(context).size.width * 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

