import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/notes_cubit/notes_cubit.dart';

List found = [];
bool isSnackBarVisible = false;

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              actions: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 10),
                    child: TextField(
                      controller: textEditingController,
                      autocorrect: false,
                      autofocus: true,
                      onChanged: (value) {
                        textEditingController.text.isEmpty
                            ? BlocProvider.of<NotesCubit>(context).clearfound()
                            : BlocProvider.of<NotesCubit>(context)
                                .foundornot(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: found.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 50.0, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(BlocProvider.of<NotesCubit>(context)
                              .notes![found[index]]
                              .title),
                          Text(BlocProvider.of<NotesCubit>(context)
                              .notes![found[index]]
                              .subTitle),
                          const Divider()
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          if (!isSnackBarVisible) {
                            copyToClipboard(
                              '${BlocProvider.of<NotesCubit>(context).notes![found[index]].title} ${BlocProvider.of<NotesCubit>(context).notes![found[index]].subTitle}',
                            );
                            BlocProvider.of<NotesCubit>(context)
                                .visblesnackbar();
                            BlocProvider.of<NotesCubit>(context)
                                .snackbar(context);
                          }
                        },
                        icon: const Icon(Icons.copy),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

Future<void> copyToClipboard(String text) async {
  await Clipboard.setData(ClipboardData(text: text));
}
