import 'package:flutter/material.dart';
import 'package:temenin_isoman_mobileapp/models/user.dart';
import 'package:temenin_isoman_mobileapp/utils/user.dart';
import 'package:temenin_isoman_mobileapp/widgets/custom_drawer.dart';
import 'package:happy_notes/models/note.dart';
import 'package:happy_notes/methods/get_data.dart';
import 'package:happy_notes/widgets/scroll_behavior.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:happy_notes/widgets/state_info.dart';
import 'package:happy_notes/widgets/note_card.dart';
import 'package:happy_notes/widgets/note_form.dart';

class NotesPage extends StatefulWidget {
  static const routeName = '/happy-notes';
  const NotesPage({Key? key}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late Future<User?> futureUser;
  Color color = Colors.white;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: customDrawer(context, futureUser),
      body: SafeArea(
        bottom: false,
        top: false,
        child: Container(
          padding: const EdgeInsets.only(
            top: 92,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(color: Colors.grey[100]),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Container(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: const Text(
                  "Send your HappyNotes to cheering up those in Isolasi Mandiri! 💗",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.pink,
              ),
              onPressed: () => _scaffoldKey.currentState!.openDrawer(),
            ),
            const SizedBox(
              height: 8,
            ),
            // cards view
            Expanded(
              child: FutureBuilder<List<Note>>(
                  future: fetchNote(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final List<Note>? notes = snapshot.data;
                      if (notes?.isNotEmpty ?? false) {
                        return ScrollConfiguration(
                          behavior: ScrollPageBehavior(),
                          child: StaggeredGridView.count(
                            crossAxisCount: 4,
                            children: List.generate(notes!.length, (index) {
                              return noteCard(context, notes[index]);
                            }),
                            staggeredTiles: notes
                                .map<StaggeredTile>(
                                    (_) => const StaggeredTile.fit(2))
                                .toList(),
                            mainAxisSpacing: 3.0,
                            crossAxisSpacing: 4.0,
                          ),
                        );
                      } else {
                        return stateInfo("No notes available", true,
                            Icons.search_off_rounded);
                      }
                    } else if (snapshot.hasError) {
                      return stateInfo(
                          snapshot.error.toString(), true, Icons.close);
                    } else {
                      return stateInfo(
                          "Load the notes", false, Icons.search_off_rounded);
                    }
                  }),
            )
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
        ),
        onPressed: () => {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return FutureBuilder(
                  future: futureUser,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return const NoteForm();
                    }
                    return const AlertDialog(
                      scrollable: true,
                      title: Text(
                        'Add Note',
                        textAlign: TextAlign.center,
                      ),
                      content: Text(
                        "Please login to add note ^^",
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                );
              }),
        },
        backgroundColor: Colors.pink,
        hoverColor: Colors.black,
        tooltip: 'Add note',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
