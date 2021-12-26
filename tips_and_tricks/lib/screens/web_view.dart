import 'package:flutter/material.dart';
import 'package:tips_and_tricks/common/styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleWebView extends StatefulWidget {
  static const routeName = '/article_web';
  final String url;

  const ArticleWebView({Key? key, required this.url}) : super(key: key);

  @override
  State<ArticleWebView> createState() => _ArticleWebViewState();
}

class _ArticleWebViewState extends State<ArticleWebView> {
  int? pos = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkSecondaryColor,
        title: const Text(
          'Tips And Tricks',
        ),
      ),
      body: IndexedStack(
        index: pos,
        children: [
          WebView(
            initialUrl: widget.url,
            onPageStarted: (value) {
              setState(() {
                pos = 1;
              });
            },
            onPageFinished: (value) {
              setState(() {
                pos = 0;
              });
            },
          ),
          const Center(
            child: CircularProgressIndicator(
              color: darkSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
