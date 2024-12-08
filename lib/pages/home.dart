import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<String> tasks = [];

  late String taskDescription = '';
  late Timer _timer;
  int _seconds = 0;
  bool _isTimerRunning = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, String>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;

    if (args != null) {
      tasks.add(args['task']!);
      taskDescription = args['taskDescription']!;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        backgroundColor: Colors.green[200],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return buildTaskTile(tasks[index]);
              },
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/form');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green[200],
        shape: const CircleBorder(),
      ),
    );
  }

  Widget buildTaskTile(String task) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListTile(
        title: Text(
          task,
          style: TextStyle(
            decoration: _isTaskCompleted(task)
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Timer: ${_seconds ~/ 60}:${(_seconds % 60).toString().padLeft(2, '0')}',
              style: const TextStyle(fontSize: 10),
            ),
            IconButton(
              icon: Icon(
                _isTimerRunning ? Icons.pause : Icons.play_arrow,
              ),
              onPressed: () {
                _toggleTimer();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.stop,
              ),
              onPressed: () {
                _stopTimer();
                _completeTask(task);
              },
            ),
          ],
        ),
      ),
    );
  }

  bool _isTaskCompleted(String task) {
    return task.endsWith('(completed)');
  }

  void _toggleTimer() {
    setState(() {
      _isTimerRunning = !_isTimerRunning;
    });
  }

  void _stopTimer() {
    if (_isTimerRunning) {
      setState(() {
        _isTimerRunning = false;
      });
    }
  }

  void _completeTask(String task) {
    int index = tasks.indexOf(task);
    if (index != -1) {
      setState(() {
        tasks[index] = tasks[index] + ' (completed)';
      });
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isTimerRunning) {
        setState(() {
          _seconds++;
        });
      }
    });
  }
}
