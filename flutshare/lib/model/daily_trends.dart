class DailyTrends {
  Title title;
  String formattedTraffic;
  List<RelatedQueries> relatedQueries;
  Image image;
  String shareUrl;

  DailyTrends({this.title, this.formattedTraffic, this.relatedQueries, this.image, this.shareUrl});

  DailyTrends.fromMap(Map<String, dynamic> map) {
    print("DAILYTREND IN");
    // this.title = Title.fromMap(map['title']);
    this.formattedTraffic = map['formattedTraffic'];
    List<dynamic> list = map['relatedQueries'];
    this.relatedQueries = list.map((f){
      return RelatedQueries.fromMap(f);
    }).toList();
    this.image = Image.fromMap(map['image']);
    this.shareUrl = map['shareUrl'];
  }
}

class Title {
  String query;
  String exploreLink;

  Title({this.query, this.exploreLink});

  Title.fromMap(Map<String, dynamic> map) {
    this.query = map['query'];
    this.exploreLink = map['exploreLink'];
  }
}

class RelatedQueries {
  String query;
  String exploreLink;

  RelatedQueries({this.query, this.exploreLink});

  RelatedQueries.fromMap(Map<String, dynamic> map) {
    this.query = map['query'];
    this.exploreLink = map['exploreLink'];
  }
}

class Image {
  String newsUrl;
  String source;
  String imageUrl;

  Image({this.newsUrl, this.source, this.imageUrl});

  Image.fromMap(Map<String, dynamic> map) {
    this.newsUrl = map['newsUrl'];
    this.source = map['source'];
    this.imageUrl = map['imageUrl'];
  }
}

