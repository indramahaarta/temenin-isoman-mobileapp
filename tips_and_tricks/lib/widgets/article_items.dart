import 'package:flutter/material.dart';
import 'package:tips_and_tricks/common/styles.dart';
import 'package:tips_and_tricks/models/article.dart';
import 'package:tips_and_tricks/screens/detail_page.dart';

Widget buildArticleItem(BuildContext context, Article article) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      shadowColor: darkSecondaryColor,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 20.0,
        ),
        leading: Hero(
          tag: article.imageUrl,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: Image.network(
              article.imageUrl,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(
          article.title,
          style: myTextTheme.bodyText1,
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.person,
                    size: 20,
                    color: darkSecondaryColor,
                  ),
                ),
                Text(article.source),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(
                    Icons.calendar_today_rounded,
                    size: 20,
                    color: darkSecondaryColor,
                  ),
                ),
                Text(
                  article.publishedDate,
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            ArticleDetailPage.routeName,
            arguments: article,
          );
        },
      ),
    ),
  );
}
