import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_login_app/repos/user_repo.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String>? users; // Make users nullable initially
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() async {
    users = await getUserName();
    setState(() {}); // Trigger a rebuild after fetching the data
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline6,
            ),
            if (users != null) // Check if users list is not null
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: users!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(users![index]),
                    );
                  },
                ),
              ),
            if (users ==
                null) // Show a loading indicator while users list is null
              CircularProgressIndicator(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
}
