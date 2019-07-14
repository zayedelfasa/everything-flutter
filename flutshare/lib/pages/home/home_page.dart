import 'package:flutter/material.dart';
import 'package:flutshare/model/news.dart';
import 'package:flutshare/model/response.dart';
import 'package:flutshare/pages/home/home_bloc.dart';
import 'package:flutshare/pages/news_webview/news_webview_page.dart';
import 'package:flutshare/styles/default_colors.dart';
import 'package:flutshare/utils/app_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutshare/utils/slide_effect.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = new HomeBloc();
    bloc.getUsaNews();
    bloc.getIndonesianNews();
  }

  @override
  void dispose() {
    super.dispose();
    // bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: DefaultColors.primaryColor,
          title: Text("Fluter Trends", style: TextStyle(color: Colors.white))
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(left: 10.0, top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset("images/trends.png", width: 30, height: 60),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0 ),
                    child: Text("Trends Today", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28), textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              constraints: BoxConstraints.expand(width: 400.0, height: 190.0),
              margin: EdgeInsets.only(left: 10.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 0,
                  ),
                  Flexible(
                      flex: 5,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(5, (int i) {
                          return Container(
                            width: 300.0,
                            margin: EdgeInsets.only(right: 1, bottom: 3),
                            child: Card(
                              elevation: 3.0,
                              child: Column(
                                children: <Widget>[
                                  new Hero(
                                    tag: "$i",
                                    child: new Material(
                                      borderRadius: new BorderRadius.circular(3.0),
                                      child: new InkWell(
                                        child: ClipRRect(
                                          borderRadius: new BorderRadius.only(topLeft: Radius.circular(3.0), topRight: Radius.circular(3.0)),
                                          child: new Image.asset("images/bg.png", fit: BoxFit.cover, height: 110, width: 300)),
                                        onTap: () => {},
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: ListTile(
                                      leading: CircleAvatar(),
                                      title: Text("Shoga Yamada",
                                          style: TextStyle(fontWeight: FontWeight.bold)),
                                      subtitle: Row(
                                        children: <Widget>[
                                          Icon(Icons.place),
                                          SizedBox(width: 10),
                                          Text("Japan")
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ))
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(left: 15.0, top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset("images/us.png", width: 30, height: 60),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0 ),
                    child: Text("Flutter Community", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28), textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              constraints: BoxConstraints.expand(width: 200.0, height: 210.0),
              margin: EdgeInsets.only(left: 10.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 0,
                  ),
                  new StreamBuilder(
                    stream: bloc.postStream(),
                    initialData: Response(statusState: StatusState.loading, data: null),
                    builder: (BuildContext context, AsyncSnapshot<Response> snapshot){
                      Response resp = snapshot.data;
                      print(resp.statusState);
                      if(resp.statusState == StatusState.loading) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 50),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Center(
                              child: new CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(DefaultColors.primaryColor),
                              ),
                            ),
                          ),
                        );
                      } else if(resp.statusState == StatusState.data) {
                        List<News> listNews = resp.data;
                        return Flexible(
                          flex: 5,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              // return Text("zz  ");
                              return newsCard(listNews[index], index, "USA_NEWS");
                            }),
                          );
                      } else {
                        return Text("There is error");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(left: 15.0, top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset("images/id.png", width: 30, height: 60),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0 ),
                    child: Text("Flutter", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28), textAlign: TextAlign.center),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              constraints: BoxConstraints.expand(width: 200.0, height: 210.0),
              margin: EdgeInsets.only(left: 10.0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 0,
                  ),
                  new StreamBuilder(
                    stream: bloc.idNewsStream() ,
                    initialData: Response(statusState: StatusState.loading, data: null),
                    builder: (BuildContext context, AsyncSnapshot<Response> snapshot){
                      Response resp = snapshot.data;
                      print(resp.statusState);
                      if(resp.statusState == StatusState.loading) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 50),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Center(
                              child: new CircularProgressIndicator(
                                valueColor: new AlwaysStoppedAnimation<Color>(DefaultColors.primaryColor),
                              ),
                            ),
                          ),
                        );
                      } else if(resp.statusState == StatusState.data) {
                        List<News> listNews = resp.data;
                        return Flexible(
                          flex: 5,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              // return Text("zz  ");
                              return newsCard(listNews[index], index, "ID_NEWS_TODAY");
                            }),
                          );
                      } else {
                        return Text("There is error");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget newsCard(News news, int index, String tag) {
    return InkWell(
      onTap: () {
        print("new inkwell onpress");
        // Navigator.push(context,EnterExitRoute( exitPage: HomePage() , enterPage: new NewsWebview(newsCompany: news.tempSource.name ,newsTitle: news.title, newsUrl: news.url)));
        Navigator.push(context, SlideEffectDuration(widget: NewsWebview(newsCompany: news.tempSource.name ,newsTitle: news.title, newsUrl: news.url)));
      },
      child: Container(
        width: 200.0,
        margin: EdgeInsets.only(right: 1, bottom: 3),
        child: Card(
          elevation: 3.0,
          child: Column(
            children: <Widget>[
              new Hero(
                tag: tag + index.toString(),
                child: new Material(
                  borderRadius: BorderRadius.circular(3.0),
                  child: ClipRRect(
                    borderRadius: new BorderRadius.only(topLeft: Radius.circular(3.0), topRight: Radius.circular(3.0)),
                    child: Image(image: CachedNetworkImageProvider(news.urlToImage == null ? "https://images.vexels.com/media/users/3/147149/isolated/preview/b80672b8545a4c8d9a04e7df58d4dc1b-news-newspaper-icon-by-vexels.png" : news.urlToImage), fit: BoxFit.cover, height: 110, width: 300)
                      // child: new Image.asset("images/bg.png" , fit: BoxFit.cover, height: 110, width: 300)
                    ),
                ),
              ),
              Flexible(
                flex: 1,
                child: ListTile(
                  title: Text(news.tempSource.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Row(
                    children: <Widget>[
                      new Expanded(
                        child: Text(news.title),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}