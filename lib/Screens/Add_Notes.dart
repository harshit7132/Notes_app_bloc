import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_bloc/Bloc/notes_bloc.dart';
import 'package:notes_app_bloc/NotesModel/notes_Model.dart';

class Add_Notes extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(hintText: 'Title'),
            controller: titleController,
          ),
          TextField(
            decoration: InputDecoration(hintText: 'Desc'),
            controller: descController,
          ),
          ElevatedButton(
              onPressed: () {
                var title = titleController.text.toString();
                var desc = descController.text.toString();
                if (title != "" && desc != "") {
                  context.read<NotesBloc>().add(AddNotesEvent(newNotes: noteModel(title: title,desc: desc)));
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enter All Fields') ));
                }
              },
              child: Text('Add Notes'))
        ],
      ),
    );
  }
}
