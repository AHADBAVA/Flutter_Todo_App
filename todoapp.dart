import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class Todo {
  final String title;
  final bool isDone;

  Todo({
    required this.title,
    this.isDone = false,
  });
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Todo> _todos = [];

  void _addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTask = '';
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            onChanged: (text) {
              newTask = text;
            },
            decoration: InputDecoration(
              hintText: 'Enter task',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                if (newTask.isNotEmpty) {
                  setState(() {
                    _todos.add(Todo(title: newTask));
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _toggleTodo(int index) {
  setState(() {
    _todos[index] = Todo(
      title: _todos[index].title,
      isDone: !_todos[index].isDone,
    );
  });
}


  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_todos[index].title),
            onDismissed: (direction) {
              _removeTodo(index);
            },
            background: Container(
              color: Color.fromARGB(255, 255, 255, 255),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(
                Icons.delete,
                color: Color.fromARGB(255, 255, 0, 0),
              ),
            ),
            child: ListTile(
              title: Text(
                _todos[index].title,
                style: TextStyle(
                  fontSize: 20.0,
                  decoration: _todos[index].isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              trailing: Checkbox(
                value: _todos[index].isDone,
                onChanged: (_) {
                  _toggleTodo(index);
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: Icon(Icons.add),
      ),
    );
  }
}
