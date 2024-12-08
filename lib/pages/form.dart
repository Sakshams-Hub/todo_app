import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _task = '';
  late String _taskDesp = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Your Task"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.task),
                  hintText: 'Enter your Task',
                  labelText: 'Task',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your task';
                  }
                  return null;
                },
                onSaved: (value) {
                  _task = value!;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.description),
                  hintText: 'Enter your Task Description',
                  labelText: 'Task Description',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your task description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _taskDesp = value!;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState != null &&
                      _formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pushNamed(context, '/home', arguments: {
                      'task': _task,
                      'taskDescription': _taskDesp,
                    });
                    print(_task);
                  }
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
