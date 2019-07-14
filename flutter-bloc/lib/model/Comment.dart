class Comment {
  String postId;
  String id;
  String name;
  String email;
  String body;

  Comment({this.postId, this.id, this.name, this.email, this.body});

  Comment.fromMap(Map<String, dynamic> map) {
    this.postId = map["postId"].toString();
    this.id = map["id"].toString();
    this.name = map["name"];
    this.email = map["email"];
    this.body = map["body"];
  }
}
