class Post{
  final String describtion;
  final String uid;
  final String username;
  final String postId;
  final String datePublished;
  final String postUrl;
  final String profImage;
  final likes;

  const Post({
    required this.describtion,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
    required this.profImage,
    required this.likes,
  });
  Map<String, dynamic> toJson(){
    return {
      'describtion': describtion,
      'uid': uid,
      'username': username,
      'postId': postId,
      'datePublished': datePublished,
      'postUrl': postUrl,
      'profImage': profImage,
      'likes': likes,
    };
  }
  static Post fromJson(Map<String, dynamic> json){
    return Post(
      describtion: json['describtion'],
      uid: json['uid'],
      username: json['username'],
      postId: json['postId'],
      datePublished: json['datePublished'],
      postUrl: json['postUrl'],
      profImage: json['profImage'],
      likes: json['likes'],
    );
  }
}