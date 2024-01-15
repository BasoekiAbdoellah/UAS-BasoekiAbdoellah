import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://uktnjxusfnuigtnflljq.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVrdG5qeHVzZm51aWd0bmZsbGpxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDUzMDIyODQsImV4cCI6MjAyMDg3ODI4NH0.DlAOxdPbrbq0cX9OTazJ08tfxVo3IdjpF_b1Pesd7Dw',
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Countries',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _future = Supabase.instance.client.from('countries').select();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _future,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final countries = snapshot.data!;
          return ListView.builder(
            itemCount: countries.length,
            itemBuilder: ((context, index) {
              final country = countries[index];
              return ListTile(
                leading: Icon(
                  Icons.flag_circle_rounded,
                  color: Colors.red,
                ),
                // trailing: Icon(Icons.flag_circle_outlined, color: Colors.amber),
                title: Text(
                  country['name'],
                  style: TextStyle(color: Colors.blue),
                ),
                subtitle: Text(country['benua']),
              );
            }),
          );
        },
      ),
    );
  }
}
