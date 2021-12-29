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
          tag: article.title,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
            child: SizedBox(
              height: 100,
              width: 100,
              child: Image.network(
                article.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (
                  BuildContext context,
                  Object exception,
                  StackTrace? stackTrace,
                ) {
                  return Image.network(
                    "https://images.unsplash.com/photo-1607077644571-11791eec3c34?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1170&q=80",
                    fit: BoxFit.cover,
                  );
                },
                loadingBuilder: (
                  BuildContext context,
                  Widget child,
                  ImageChunkEvent? loadingProgress,
                ) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: darkSecondaryColor,
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
              ),
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
