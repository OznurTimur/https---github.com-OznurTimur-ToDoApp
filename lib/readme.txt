# To-Do App Documentation

## Overview
The To-Do App is a simple mobile application built using Flutter. It allows users to manage their tasks by adding, completing, and viewing them in separate lists. This documentation provides an overview of the app's structure and functionality.

## Table of Contents
1. [Introduction](#overview)
2. [Code Structure](#code-structure)
3. [Classes and Functions](#classes-and-functions)
4. [Usage](#usage)
5. [Contributing](#contributing)

## Code Structure

The code is organized into several classes to maintain a clear and modular structure:

1. **`main.dart`**: Entry point of the application, containing the `main` function to start the app.
2. **`Task`**: A class representing a task with properties like `title`, `description`, `dueDate`, and `isCompleted`.
3. **`MyApp`**: The main application widget that sets up the MaterialApp.
4. **`TodoListScreen`**: A StatefulWidget representing the main screen of the app.
5. **`_TodoListScreenState`**: The corresponding State class for `TodoListScreen`.

## Classes and Functions

### Task
- **Properties**:
  - `title` (String): The title of the task.
  - `description` (String): A description of the task.
  - `dueDate` (DateTime?): An optional due date for the task.
  - `isCompleted` (bool): A boolean indicating whether the task is completed.

### MyApp
- **Constructor**:
  - `MyApp({Key? key})`: Constructor for the `MyApp` widget.

- **Methods**:
  - `build(BuildContext context)`: The `build` method to create the main MaterialApp widget.

### TodoListScreen
- **Constructor**:
  - `TodoListScreen({Key? key, required this.title})`: Constructor for the `TodoListScreen` widget.

- **State Class**: `_TodoListScreenState` is the associated State class for `TodoListScreen`.

- **Properties**:
  - `title` (String): The title of the screen.

- **Methods**:
  - `addTask(String title, String description, DateTime? dueDate)`: Adds a new task to the pending tasks list.
  - `toggleShowCompletedTasks()`: Toggles the display of completed tasks.
  - `_showTaskDialog(BuildContext context)`: Displays a dialog to add a new task.
  - `build(BuildContext context)`: Builds the UI of the screen.

## Usage

1. **Adding a Task**: Click on the "+" button to open the "Add a New Task" dialog. Fill in the task title, description, and optionally select a due date. Click "Add" to add the task to the pending tasks list.

2. **Toggling Task Lists**: Use the "Pending Tasks" and "Completed Tasks" buttons to switch between the lists of pending and completed tasks.

3. **Completing Tasks**: Toggle the checkboxes next to each task to mark them as completed. Completed tasks will move to the "Completed Tasks" list.

