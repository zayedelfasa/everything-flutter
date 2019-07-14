class EndPoint {
  static String trendsApi = "http://172.16.2.22:3333/api/v1/";
  static String interestOverTime = trendsApi + "interestOverTime";
  static String interestOverTimeMultiple = trendsApi + "interestOverTimeMultiple";
  static String dailyTrends = trendsApi + "dailyTrends";
  static String interestByRegion = trendsApi + "interestByRegion";
  static String realtimeTrends = trendsApi + "realtimeTrends";

  static String newsApiKey = "85ba499e96e8437ca2458ca6f483bdaf";
  static String newsApiHttp = "https://newsapi.org/v2/";
  // static String newsApiHttpTopHeadLinesUsa = newsApiHttp + "top-headlines?apiKey="+newsApiKey+"&country=us";
  static String newsApiHttpTopHeadLinesUsa = "https://newsapi.org/v2/everything?q=flutter&sortBy=publishedAt&apiKey=85ba499e96e8437ca2458ca6f483bdaf";
  static String newsApiHttpTopHeadLinesID = newsApiHttp + "top-headlines?apiKey="+newsApiKey+"&country=id";

  String getNewsApiHttpTopByCountry(String idState) {
    return newsApiHttp + "top-headlines?apiKey="+newsApiKey+"&country="+idState;
  }
}