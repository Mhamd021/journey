class Post {
   int id;
   String postInfo;
   String? postImage;
   String createdAt;
   String updatedAt;
   int commentsCount;
   int likesCount;
   bool hasLiked;
   User user;

  Post({
    required this.id,
    required this.postInfo,
    this.postImage,
    required this.createdAt,
    required this.updatedAt,
    required this.commentsCount,
    required this.likesCount,
    required this.hasLiked,
    required this.user,
  });

  factory Post.fromJson(Map<String, dynamic> json) 
  {
    return Post(
      id: json['id'],
      postInfo: json['post_info'],
      postImage: json['post_image'] ?? '', 
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      commentsCount: json['comments_count'],
      likesCount: json['likes_count'],
      hasLiked: json['has_liked'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final int id;
  final String name;
  final String? userImage;

  User({required this.id, required this.name, this.userImage});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      userImage: json['user_image'] ?? '', 
    );
  }
}