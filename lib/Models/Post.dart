class Post {
  int id;
  String username;
  String title;
  String body;

  Post({this.username, this.title, this.body}) {
    id = -1;
  }

  Post.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    id = json['id'];
    title = json['title'];
    body = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['title'] = this.title;
    data['content'] = this.body;
    return data;
  }
}
