import 'package:rokney/backends/backends.dart';

// for the storing the users data temporarily before going backendly

class DatabaseMethod {
  // for users profile
  List<UserProfile> usersProfile = [];
  UserProfile userProfile = UserProfile();

  // for posts
  Post post = Post();
  List<Post> posts = [];

  List<Map<String, dynamic>> usersMap = [
    {
      'username': 'Adeyori',
      'image': './assets/images/bg.png',
      'followers': 230,
      'following': 379,
      'about':
          'Talks about #technology, #programming, #webdevelopment, and #mobiledevelopment',
      'address': 'University of Lagos, Unilag\n Nigeria.',
      'professions': ['Software developer', 'Sells Robots']
    },
    {
      'username': 'Adeyori',
      'image': './assets/images/bg.png',
      'followers': 230,
      'following': 379,
      'about':
          'Talks about #technology, #programming, #webdevelopment, and #mobiledevelopment',
      'address': 'University of Lagos, Unilag\n Nigeria.',
      'professions': ['Software developer', 'Sells Robots']
    },
    {
      'username': 'Adeyori',
      'image': './assets/images/bg.png',
      'followers': 230,
      'following': 379,
      'about':
          'Talks about #technology, #programming, #webdevelopment, and #mobiledevelopment',
      'address': 'University of Lagos, Unilag\n Nigeria.',
      'professions': ['Software developer', 'Sells Robots']
    },
    {
      'username': 'Adeyori',
      'image': './assets/images/bg.png',
      'followers': 230,
      'following': 379,
      'about':
          'Talks about #technology, #programming, #webdevelopment, and #mobiledevelopment',
      'address': 'University of Lagos, Unilag\n Nigeria.',
      'professions': ['Software developer', 'Sells Robots']
    },
    {
      'username': 'Adeyori',
      'image': './assets/images/bg.png',
      'followers': 230,
      'following': 379,
      'about':
          'Talks about #technology, #programming, #webdevelopment, and #mobiledevelopment',
      'address': 'University of Lagos, Unilag\n Nigeria.',
      'professions': ['Software developer', 'Sells Robots']
    }
  ];

  // returns a list of the data of all users
  List<UserProfile> getUsers() {
    for (var element in usersMap) {
      usersProfile.add(UserProfile(
          about: element['about'],
          username: element['username'],
          profileImage: element['image'],
          address: element['address'],
          followers: element['followers'],
          following: element['following'],
          professions: element['professions']));
    }

    return usersProfile;
  }

  // creating posts
  List<Post> getPosts() {
    for (var post in usersMap) {
      posts.add(Post(
          images: post['images'],
          text: 'hello world',
          username: post['username']));
    }

    return posts;
  }
}
