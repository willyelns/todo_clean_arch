import 'package:flutter/material.dart';

class AddTaskPageMobx extends StatelessWidget {
  const AddTaskPageMobx({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add task - MobX'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Form(
              child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {},
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) {},
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: ElevatedButton(
                  onPressed: () {
                    print('created');
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Add task'.toUpperCase(),
                    ),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
