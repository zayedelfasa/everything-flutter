import 'package:flutter/material.dart';
import 'MyBloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  
  final String title;
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double sum = 0;
  var controller1 = TextEditingController();
  var controller2 = TextEditingController();
  
  MyBloc myBloc;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myBloc = MyBloc();
  }
  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myBloc.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: myBloc.getStream(),
        builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
          return new ListView(
            children: <Widget>[
              new TextField(
                controller: controller1,
                keyboardType: TextInputType.number,
              ),
              new TextField(
                controller: controller2,
                keyboardType: TextInputType.number,
              ),
              new RaisedButton(
                child: new Text("Add"),
                onPressed: () {
                  double num1 = double.parse(controller1.text);
                  double num2 = double.parse(controller2.text);
                  myBloc.doSum(num1, num2);
                }),
              new Text(snapshot.data== null ? "Result" : snapshot.data.toString())
            ],
          );
        })// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
