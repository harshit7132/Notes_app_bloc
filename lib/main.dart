import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_bloc/Bloc/notes_bloc.dart';
import 'package:notes_app_bloc/DataBase/DB_Helper.dart';
import 'Screens/Add_Notes.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => NotesBloc(db: DB_helper.db),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    context.read<NotesBloc>().add(FetchNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController utitleController = TextEditingController();
    TextEditingController udescController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text('Notes App Bloc'),
        ),
        body: BlocBuilder<NotesBloc, NotesState>(builder: (context, state) {
          if (state is NotesLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is NotesError) {
            return Center(child: Text('${state.errorMsg}'));
          } else if (state is NotesLoaded) {
            return state.arrnotes.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      var thisNote = state.arrnotes[index];
                      return GestureDetector(
                        onTap: (){
                          showModalBottomSheet(context: context, builder: (context) {
                            return SizedBox(
                              height: 500,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  TextField(
                                    controller:utitleController ,
                                    decoration: InputDecoration(hintText: '${thisNote.title}'),
                                  ),
                                  TextField(
                                    controller: udescController,
                                    decoration: InputDecoration(hintText: '${thisNote.desc}'),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        var utitle = utitleController.text.toString();
                                        var udesc = udescController.text.toString();

                                              context.read<NotesBloc>().add(updateNotesEvent(id: thisNote.note_id!, title: utitle,desc: udesc,));
                                              Navigator.pop(context);
                                      },
                                      child: Text('Update Notes'))
                                ],
                              ),
                            );
                          });
                        },
                        child: ListTile(
                          leading: Text('${index + 1}'),
                          title: Text('${thisNote.title}'),
                          subtitle: Text('${thisNote.desc}'),
                          trailing: IconButton(
                              onPressed: () {
                                context.read<NotesBloc>().add(deleteNotesEvent(id: thisNote.note_id!));
                              }, icon: Icon(Icons.delete)),
                        ),
                      );
                    },
                    itemCount: state.arrnotes.length,
                  )
                : Center(child: Text('Notes Are Empty'));
          }
          return Container();
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Add_Notes()));
          },
          tooltip: 'Add Notes',
          child: const Icon(Icons.add),
        ));
  }
}
