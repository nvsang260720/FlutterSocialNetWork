class Post {
  String content;
  List<dynamic> images;
  String type;
  String username;
  String avatar;
  String createdAt;
  List<dynamic> like;
  String userID;
  String id;
  List<dynamic> comment;
  Post(
      {required this.content,required this.comment,
      required this.id,
      required this.userID,
      required this.images,
      required this.type,
      required this.username,
      required this.avatar,
      required this.createdAt,
      required this.like});
  // factory Post.fromJson(Map<String, dynamic> responseData) {

  //   return Post(avatar: ,
  //   createdAt: ,
  //   like: ,
  //   userID: ,
  //   username: ,
  //     content: responseData['content'],
  //     images: responseData['images'],
  //     type: responseData['type'],
  //   );
  // }
}
