import 'package:flutter/material.dart';
import 'package:msh_checkbox/msh_checkbox.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_provider/model/todo_model.dart';
import 'package:to_do_list_provider/provider/todo_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final _textController = TextEditingController();

  Future<void> _showDialog() async{
    return showDialog(
      context: context,
      builder: (context){
        return  AlertDialog(
          title: const Text("Add todo List"),
          content: TextField(
            controller: _textController,
            decoration: const InputDecoration( hintText: ("write to do item"),),
          ),
          actions: [
            TextButton(
              onPressed: (){
                Navigator.pop(context);},
              child: const Text("Cancel")),

            TextButton(
                onPressed: (){

                  if(_textController.text.isEmpty){
                    return;
                  }

                  context.read<TodoProvider>().addToDoList(
                    TODOModel(
                        title: _textController.text,
                        isCompleted: false
                    )
                  );

                  _textController.clear();
                  Navigator.pop(context);
                },
                child: const Text("Submit"))
          ]
        );
      });
  }



  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<TodoProvider>(context);


    return Scaffold(
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.lightGreen[90]
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration:  BoxDecoration(
                        color: Colors.lightGreen[200],
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                        ),
                    ),
                    child: const Center(child: Text(
                        "TO DO ",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54
                      )
                    ))
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: ListView.builder(
                      itemBuilder: (context,itemIndex){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: Colors.lightGreen[100],
                            child: ListTile(
                              onTap: (){
                                provider.todoStatusChange(provider.allTODOList[itemIndex]);
                              },
                              leading: MSHCheckbox(
                                size: 30,
                                value: provider.allTODOList[itemIndex].isCompleted,
                                colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(checkedColor: const Color(0xFF8FCBA8)),
                                style: MSHCheckboxStyle.stroke,
                                onChanged: (selected){
                                  provider.todoStatusChange(provider.allTODOList[itemIndex]);
                                },
                              ),
                              title: Text(
                                  provider.allTODOList[itemIndex].title,
                                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                  decoration:
                                  provider.allTODOList[itemIndex].isCompleted ==
                                      true
                                      ?
                                  TextDecoration.lineThrough
                                      : null),
                              ),
                              trailing: IconButton(
                                onPressed: (){
                                  provider.removeToDoList(provider.allTODOList[itemIndex]);
                                }, icon: const Icon(Icons.delete),
                              ),
                            ),
                          ),
                        );
                      }, itemCount: provider.allTODOList.length,
                  ),
                ),
              ],
            ),
          ),
       ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightGreen[200],
        onPressed: () {
          _showDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
