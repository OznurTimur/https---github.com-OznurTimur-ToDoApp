// ANTONIO Readability and Structure
// ANTONIO All variables are consistent and follow the same naming convention
// ANTONIO The code is very well structured and easy to follow
// ANTONIO There are no comments in the code which makes some parts harder to understand
// ANTONIO However the readme file and the clear variable names make it clear enough

// ANTONIO Logic and Functionality
// ANTONIO The code produces the expected outputs
// ANTONIO The app does take into account edge cases such as empty task titles
// ANTONIO It is worth noting that you can add tasks with empty descriptions or dates

// ANTONIO Code Structure and Design
// ANTONIO The code has modularity incorporated into its structure
// ANTONIO However there are some parts of the code that could be reformatted
// ANTONIO For example, the addTask, toggleShowCompletedTasks and _showTaskDialog functions...
// ... could be extracted into a separate class in order to simplify the _todoListScreenState class
// ANTONIO There are no duplicated parts of code that could be turned into functions
// ANTONIO The coder makes proper use of libraries and imports

// ANTONIO Maintainability
// ANTONIO Making changes to the code could be hard in the future because of the functions being in the same class
// ANTONIO Also, since the code only uses one screen for completed and pending tasks...
// ... it could be hard to add new features to the app in the future without reformatting...
// ... the existing code for separating the completed and pending tasks screens
// ANTONIO The README file that accompanies the code is clear and explains the code for...
// ... anyone who wants to make changes to it in the future

// ANTONIO Collaboration and Workflow
// ANTONIO I cannot comment on the commit messages since I cannot see them on GitHub
// ANTONIO The files are organized in a logical matter and follow standard flutter protocol

// ANTONIO Usability
// ANTONIO The app is very responsive and has no noticeable delay in the inputs
// ANTONIO The app does not use a NavBar for smaller screens which makes it a bit harder to use
// ANTONIO When adding a new task it would be better if it displayed the selected date after being selected
// ANTONIO The User Interface could be improved in order to look more clean and consistent

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Task {
  final String title;
  final String description;
  final DateTime? dueDate;
  bool isCompleted;

  Task(this.title, this.description, this.dueDate, this.isCompleted);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 120, 194, 178)),
        useMaterial3: true,
      ),
      home: const TodoListScreen(title: 'To-Do List'),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key, required this.title});

  final String title;

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> pendingTasks = [];
  List<Task> completedTasks = [];
  bool showCompletedTasks = false;

  void addTask(String title, String description, DateTime? dueDate) {
    setState(() {
      pendingTasks.add(Task(title, description, dueDate, false));
    });
  }

  void toggleShowCompletedTasks() {
    setState(() {
      showCompletedTasks = !showCompletedTasks;
    });
  }

  void _showTaskDialog(BuildContext context) { 
    String newTaskTitle = "";
    String newTaskDescription = "";
    DateTime? newDueDate;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add a New Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  newTaskTitle = value;
                },
                decoration: InputDecoration(
                  hintText: "Task title",
                ),
              ),
              TextField(
                onChanged: (value) {
                  newTaskDescription = value;
                },
                decoration: InputDecoration(
                  hintText: "Task description",
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                  if (selectedDate != null) {
                    newDueDate = selectedDate;
                  }
                },
                child: Text("Select Due Date"),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Add"),
              onPressed: () {
                if (newTaskTitle.isNotEmpty) {
                  addTask(newTaskTitle, newTaskDescription, newDueDate);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(showCompletedTasks ? 'Completed Tasks' : 'Pending Tasks',
        textAlign:TextAlign.center),
        centerTitle:true
      ),
      body: Row(
        children: [
          Container(
            width: 150,
            color: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showCompletedTasks = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  child: Text("Pending Tasks"),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showCompletedTasks = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                  child: Text("Completed Tasks"),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: showCompletedTasks ? completedTasks.length : pendingTasks.length,
                      itemBuilder: (context, index) {
                        final task = showCompletedTasks ? completedTasks[index] : pendingTasks[index];
                        return ListTile(
                         title: Text(task.title),
                         subtitle: Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                         Text(task.description),
                           if (task.dueDate != null) Text('Due Date: ${task.dueDate!.toLocal()}'), // Display due date if available
                         ],
                         ),
                        trailing: Checkbox(
                         value: task.isCompleted,
                          onChanged: (newValue) {
                          setState(() {
                           task.isCompleted = newValue!;
                            if (task.isCompleted) {
                             pendingTasks.remove(task);
                              completedTasks.add(task);
                               } else {
                                completedTasks.remove(task);
                                  pendingTasks.add(task);
                                  }
                                });
                              },
                            ),
                         );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showTaskDialog(context);
        },
        tooltip: 'Add Task',
        child: Icon(Icons.add),
      ),
    );
  }
}
