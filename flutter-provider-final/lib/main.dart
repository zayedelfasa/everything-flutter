import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_example/locator.dart';
import 'package:provider_example/utils/AppState.dart';

import 'main_two.dart';

// void main() => runApp(MaterialApp(home: MyApp()));
void main() {
  setupLocator();
  runApp(MainTwo());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Provider Example",
      theme: ThemeData(primaryColor: Colors.blue),
      home: ChangeNotifierProvider<AppState>(
        builder: (val) => AppState(),
        child: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Halaman Provider"),
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            children: <Widget>[
              TextDisplayWidget(),
              TextEditWIdget(),
              RaisedButton(child: Text("Fetch Data From Network"), onPressed: () => appState.fetchData()),
              ResponseDisplay(),
            ],
          ),
        ),
      ),
    );
  }
}

class ResponseDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Container(
      padding: EdgeInsets.all(8.0),
      child: appState.isFetching
          ? Container(
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Loading"),
                  )
                ],
              ),
            )
          : appState.getResponseJson() != null
              ? ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: appState.getResponseJson().length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          appState.getResponseJson()[index]['avatar'],
                        ),
                      ),
                      title: Text(appState.getResponseJson()[index]['first_name']),
                    );
                  },
                )
              : Text("Press Button above to fetch data"),
    );
  }
}

class TextDisplayWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Container(
      child: Text(
        appState.getDisplayText(),
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }
}

class TextEditWIdget extends StatefulWidget {
  @override
  _TextEditWIdgetState createState() => _TextEditWIdgetState();
}

class _TextEditWIdgetState extends State<TextEditWIdget> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return Container(
      child: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(
          labelText: "Some Text",
          border: OutlineInputBorder(),
        ),
        onChanged: (changed) => appState.setDisplayText(changed),
        onSubmitted: (submitted) => appState.setDisplayText(submitted),
      ),
    );
  }
}
