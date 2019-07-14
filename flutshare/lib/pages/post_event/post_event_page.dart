import 'package:flutter/material.dart';
import 'package:flutshare/pages/post_event/post_event_bloc.dart';
import 'package:flutshare/styles/default_colors.dart';
import 'package:flutshare/styles/default_styles.dart';

class PostEvent extends StatefulWidget {
  @override
  _PostEvetnState createState() => _PostEvetnState();
}

class _PostEvetnState extends State<PostEvent> {
  final _formKey = GlobalKey<FormState>();
  PostEventValue postEventValue;
  PostEventBloc postEventBloc; 
  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController picController = TextEditingController();
  final TextEditingController coordinateController = TextEditingController();
  final TextEditingController deskController = TextEditingController();


  @override
  void initState() {
    super.initState();
    postEventValue = PostEventValue();
    postEventBloc = PostEventBloc();
  }

  @override
  void dispose() {
    super.dispose();
    postEventBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DefaultColors.primaryColor,
        title: Text("Post Event", style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Form(
                key: _formKey,
                child: form(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget form() {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Event Name", style: DefaultStyle.textStyleLabelForm),
                TextFormField(
                  controller: eventNameController,
                  decoration: DefaultStyle()
                      .defaultInputDecorationForm("Input Event Name"),
                  keyboardType: TextInputType.text ,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Input Event Name";
                    }
                  },
                  onSaved: (value) {
                    postEventValue.name = value;
                  },
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Address", style: DefaultStyle.textStyleLabelForm),
                TextFormField(
                  controller: addressController,
                  decoration: DefaultStyle()
                      .defaultInputDecorationForm("Input adress here"),
                  keyboardType: TextInputType.text , 
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Input Adress";
                    }
                  },
                  onSaved: (value) => postEventValue.address = value,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("PIC", style: DefaultStyle.textStyleLabelForm),
                TextFormField(
                  controller: picController,
                  decoration:
                      DefaultStyle().defaultInputDecorationForm("Input PIC Here"),
                  keyboardType: TextInputType.text ,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Input PIC here";
                    }
                  },
                  onSaved: (value) => postEventValue.pic = value,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Description", style: DefaultStyle.textStyleLabelForm),
                TextFormField(
                  controller: deskController,
                  decoration: DefaultStyle()
                      .defaultInputDecorationForm("Input Description Here"),
                  keyboardType: TextInputType.text ,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Input Desctiption Here";
                    }
                  },
                  onSaved: (value) => postEventValue.deskripsi = value,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Coordinate", style: DefaultStyle.textStyleLabelForm),
                TextFormField(
                  controller: coordinateController,
                  decoration: DefaultStyle()
                      .defaultInputDecorationForm("Input Coordinate Here"),
                  keyboardType: TextInputType.text ,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please Input Coordinate Here";
                    }
                  },
                  onSaved: (value) => postEventValue.coordinate = null,
                )
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: this.saveEventPost,
                color: DefaultColors.primaryColor,
                shape: DefaultStyle().roundedRectangleBorderDefault(),
                child:
                    Text("Post Now", style: DefaultStyle.textStyleButtonDefault),
              ))
        ],
      ),
    );
  }

  void saveEventPost() {
    print("SAVE EVENT RIGHT NOW");
    postEventValue.name = eventNameController.text;
    postEventValue.address = addressController.text;
    postEventValue.coordinate = null;
    postEventValue.pic = picController.text;
    postEventValue.deskripsi = deskController.text;
    print(postEventValue.name);
    postEventBloc.newPostEvent(postEventValue);
    // postEventBloc.createGroup();
  }
}

class PostEventValue {
  String address;
  String name;
  String pic;
  String deskripsi;
  List<double> coordinate;
}
