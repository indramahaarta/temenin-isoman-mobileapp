import 'package:flutter/material.dart';
import 'package:tips_and_tricks/models/article.dart';
import 'package:tips_and_tricks/screens/web_view.dart';
import 'package:tips_and_tricks/common/styles.dart';

class ArticleDetailPage extends StatelessWidget {
  static const routeName = '/article_detail';

  final Article article;

  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Hero(
              tag: article.imageUrl,
              child: Image.network(
                article.imageUrl,
                // width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .45,
                fit: BoxFit.fill,
              ),
            ),
            DraggableScrollableSheet(
              maxChildSize: .8,
              initialChildSize: .6,
              minChildSize: .6,
              builder: (context, scrollController) {
                return Container(
                  height: MediaQuery.of(context).size.height * .75,
                  padding: const EdgeInsets.only(
                    left: 19,
                    right: 19,
                    top: 16,
                  ), //symmetric(horizontal: 19, vertical: 16),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: secondaryColor.withOpacity(0.5),
                        spreadRadius: 3,
                        blurRadius: 7,
                        offset: const Offset(
                          0,
                          2,
                        ), // changes position of shadow
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    controller: scrollController,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          article.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const Divider(color: Colors.grey),
                        Text('Published Date: ${article.publishedDate}'),
                        const SizedBox(height: 10),
                        Text('Author: ${article.source}'),
                        const Divider(color: Colors.grey),
                        Text(
                          article.briefDescription,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: darkSecondaryColor,
                            textStyle: myTextTheme.button,
                          ),
                          child: const Center(
                            child: Text('Read more'),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              ArticleWebView.routeName,
                              arguments: article.articleUrl,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                BackButton(color: Theme.of(context).primaryColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
