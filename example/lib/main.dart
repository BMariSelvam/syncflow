import 'package:flutter/material.dart';
import 'package:syncflow/syncflow.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SyncManager.initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('SyncFlow Demo')),
        body: Center(
          child: ElevatedButton(
            onPressed: () async {
              await SyncManager.request(
                method: 'POST',
                url: 'https://jsonplaceholder.typicode.com/posts',
                body: {'title': 'Flutter', 'body': 'Offline Sync'},
              );
            },
            child: const Text('Send API'),
          ),
        ),
      ),
    );
  }
}
