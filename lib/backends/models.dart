// users model

class User {
  final String username, email;

  User({required this.email, required this.username});
}

class UserProfile {
  final String about, address, profileImage;
  final String username;
  final int followers, following;
  final List<String> professions;

  UserProfile(
      {required this.about,
      required this.address,
      required this.followers,
      required this.username,
      required this.profileImage,
      required this.following,
      required this.professions});
}

// model for post by users
class Post {
  final String? text, username;
  bool? myPost;
  final List<String>? images;

  Post({this.images, this.text, this.username, this.myPost});
}
