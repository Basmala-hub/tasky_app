import 'package:flutter/material.dart';
import 'package:tasky/features/home/data/task_model.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  SearchScreen({super.key, tasks});
  static final String routeName = "SearchScreen";
  List<TaskModel> tasks = [];
  @override
  State<SearchScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SearchScreen> {
  TextEditingController? search;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.cancel),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              TextField(
                controller: search,
                decoration: InputDecoration(
                  hintText: "Search for your task...",
                  border: OutlineInputBorder(),
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  ),
                ),
              ),

              SizedBox(height: 50),

              Expanded(
                child: ListView.builder(
                  itemCount: widget.tasks.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(widget.tasks[index].title));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
