// users model

class User {
  final String username, email;

  User({required this.email, required this.username});
}

class UserProfile {
  final String? about, address, profileImage, username;
  final int? followers, following;
  final List<String>? professions;

  UserProfile(
      {this.about,
      this.address,
      this.followers,
      this.username,
      this.profileImage,
      this.following,
      this.professions});
}

// model for post by users
class Post {
  final String? text, username;
  final List<String>? images;

  Post({this.images, this.text, this.username});
}
