import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/widgets/custom_drawer.dart';
import 'package:tips_and_tricks/common/styles.dart';
import 'package:tips_and_tricks/widgets/article_items.dart';
import 'package:tips_and_tricks/dummy_data.dart';
import 'package:tips_and_tricks/screens/add_article_page.dart';

class TipsAndTricksListPage extends StatelessWidget {
  static const routeName = '/tips-and-tricks';

  const TipsAndTricksListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: darkSecondaryColor,
          title: Center(
            child: Text(
              'COVID-19 Tips And Tricks',
              style: myTextTheme.headline6,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.add,
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddArticlePage(),
                  ),
                );
                // do something
              },
            )
          ],
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.short_text,
                  size: 30,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: customDrawer(context),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(150),
                ),
                elevation: 3,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 50,
                  child: const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.search_rounded,
                        color: darkSecondaryColor,
                      ),
                      hintText: 'Search...',
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 20.0,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: secondaryColor,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: darkSecondaryColor,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(32.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: listArticles.length,
                itemBuilder: (context, index) {
                  return buildArticleItem(
                    context,
                    listArticles[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
