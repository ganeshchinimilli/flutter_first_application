import 'package:flutter/material.dart';

class MyTodoApp extends StatelessWidget{
  const MyTodoApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme:ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {

  @override
  // ignore: library_private_types_in_public_api
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<Todo> _todos = <Todo>[];

  @override
  // Widget build(BuildContext context) {
  //   return  Scaffold(
  //     appBar: AppBar(
  //       title: Text('Todo List'),
  //     ),
  //     body: ListView.builder(
  //       itemCount: _todos.length,
  //       itemBuilder: (context, index) {
  //         return Dismissible(
  //           key: Key(_todos[index].name),
  //           onDismissed: (direction) {
  //             setState(() {
  //               _todos.removeAt(index);
  //             });
  //           },
  //           child: ListTile(
  //             title: Text(_todos[index].name),
  //             trailing: Checkbox(
  //               value: _todos[index].checked,
  //               onChanged: (value) {
  //                 setState(() {
  //                   _todos[index].checked = value!;
  //                 });
  //               },  
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //     floatingActionButton: FloatingActionButton(
  //       onPressed: _pushAddTodoScreen,
  //       tooltip: 'Add Todo',
  //       child: Icon(Icons.add),
  //     ),

  //   );
  // }

  // void _pushAddTodoScreen() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute<void>(
  //       builder: (context) {
  //         return Scaffold(
  //           appBar: AppBar(
  //             title: Text('Add a new Todo'),
  //           ),
  //           body: TextField(
  //             controller: _controller,
  //             autofocus: true,
  //             onSubmitted: (val) {
  //               _addTodoItem(val);
  //               Navigator.pop(context); // Close the add todo screen
  //             },
  //             decoration: InputDecoration(
  //               hintText: 'Enter something to do...',
  //               contentPadding: EdgeInsets.all(16.0),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  // void _addTodoItem(String name) {
  //   setState(() {
  //     _todos.add(Todo(name: name, checked: false));
  //   });
  //   _controller.clear();
  // }
  Widget build (BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
      ),
      body:ListView(
        padding:EdgeInsets.symmetric(vertical: 8.0),
        children: _todos.map((Todo todo) {
          return TodoItem(
            todo: todo,
            onTodoChanged: _handleTodoChange,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _displayDialog(),
        tooltip: 'Add Todo',
        child:Icon (Icons.add)
      ),
    );
  }
  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }
  void _addTodoItem(String name) {
	setState(() {
	  _todos.add(Todo(name: name, checked: false));
	});
	_textFieldController.clear();
  }
   Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new todo item'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type your new todo'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                // place the validation 
                if(_textFieldController.text != ''){
                  print(_textFieldController.text);
                  _addTodoItem(_textFieldController.text);
                }else{
                  // add an error to the screen
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please enter some text',
                      )
                    )
                  );
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
 class TodoItem extends StatelessWidget{

  TodoItem({
    required this.todo,
    required this.onTodoChanged
  }):super(key:ObjectKey(todo));

  final Todo todo;
  // ignore: prefer_typing_uninitialized_variables
  final onTodoChanged;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onTodoChanged(todo);
      },
      leading: CircleAvatar(
        child: Text(todo.name[0]),
      ),
      title: Text(todo.name, style: _getTextStyle(todo.checked)),
    );
  }
}


class Todo {
  Todo({required this.name,required this.checked});
  final String name;
  bool checked;
}