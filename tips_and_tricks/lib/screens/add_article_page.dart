import 'package:flutter/material.dart';
import 'package:tips_and_tricks/common/styles.dart';
import 'package:tips_and_tricks/methods/add_data.dart';
import 'package:tips_and_tricks/models/article.dart';
import 'package:tips_and_tricks/widgets/custom_scaffold.dart';
import 'list_page.dart';

class AddArticlePage extends StatefulWidget {
  static const routeName = '/add_article';

  const AddArticlePage({Key? key}) : super(key: key);

  @override
  State<AddArticlePage> createState() => _AddArticlePageState();
}

class _AddArticlePageState extends State<AddArticlePage> {
  late String articleTitle;
  late String articleSource;
  late String articlePublishedDate;
  late String imageUrl;
  late String articleUrl;
  late String briefDescription;

  DateTime selectedDate = DateTime.now();
  final TextEditingController _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1990, 1),
      lastDate: DateTime(2023),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: primaryColor, // header background color
              onPrimary: Colors.black, // header text color
              onSurface: darkSecondaryColor, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                primary: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        articlePublishedDate = picked.toString().substring(0, 10);
        _dateController.text = picked.toString().substring(0, 10);
      });
    }
  }

  Widget customForm(String label) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 35.00,
        right: 35.00,
        top: 20.00,
      ),
      child: TextFormField(
        validator: (value) {
          if (value?.isEmpty ?? true) {
            String temp = label.toLowerCase();
            return 'Please enter article $temp';
          }
          if (label == "Title") {
            articleTitle = value!;
          } else if (label == "Source/Author") {
            articleSource = value!;
          } else if (label == "Image URL") {
            imageUrl = value!;
          } else if (label == "URL") {
            articleUrl = value!;
          } else if (label == "Brief Description") {
            briefDescription = value!;
          }
        },
        style: myTextTheme.bodyText1,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: darkSecondaryColor,
            ),
          ),
          labelText: label,
          labelStyle: const TextStyle(
            color: darkSecondaryColor,
          ),
        ),
        cursorColor: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _dateController.text = selectedDate.toString().substring(0, 10);
    articlePublishedDate = selectedDate.toString().substring(0, 10);
    return SafeArea(
      child: CustomScaffold(
        theTitle: 'Add New Article',
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              right: 15.0,
              left: 15.00,
              top: 50.00,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Fill All the Fields",
                        style: myTextTheme.headline4?.apply(
                          color: darkSecondaryColor,
                          fontWeightDelta: 1,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: Form(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      key: _formKey,
                      child: Column(
                        children: [
                          customForm("Title"),
                          customForm("Source/Author"),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 35.00,
                              right: 35.00,
                              top: 20.00,
                            ),
                            child: TextFormField(
                              controller: _dateController,
                              style: myTextTheme.bodyText1,
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: darkSecondaryColor,
                                  ),
                                ),
                                labelText: 'Article Publish Date',
                                labelStyle: const TextStyle(
                                  color: darkSecondaryColor,
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.calendar_today_rounded,
                                  ),
                                  onPressed: () => _selectDate(context),
                                ),
                              ),
                              cursorColor: Colors.black,
                            ),
                          ),
                          customForm("Image URL"),
                          customForm("URL"),
                          customForm("Brief Description"),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(
                        10.0,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: darkSecondaryColor,
                        ),
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            Article newArticle = Article(
                              title: articleTitle,
                              source: articleSource,
                              publishedDate: articlePublishedDate,
                              imageUrl: imageUrl,
                              articleUrl: articleUrl,
                              briefDescription: briefDescription,
                            );
                            addNewArtikel(newArticle).then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    value,
                                  ),
                                ),
                              );
                            });
                            Navigator.pushNamed(
                              context,
                              TipsAndTricksListPage.routeName,
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 20.0,
                            left: 20.0,
                          ),
                          child: Text(
                            'Submit',
                            style: myTextTheme.bodyText2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
