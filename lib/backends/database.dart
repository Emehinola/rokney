import 'package:rokney/backends/backends.dart';
import 'package:rokney/backends/backends.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

// for the storing the users data temporarily before going backendly

class DatabaseMethod {
  // for users profile
  List<UserProfile> usersProfile = [];

  // for posts
  List<Post> posts = [];

  List<Map<String, dynamic>> postsMap = [
    {
      'username': 'Chigozie',
      'images': ['./assets/images/bg.png', './assets/images/mult.png'],
      'followers': 230,
      'following': 379,
      'about':
          'Talks about #technology, #programming, #webdevelopment, and #mobiledevelopment',
      'address': 'University of Lagos, Unilag\n Nigeria.',
      'professions': ['Software developer', 'Sells Robots']
    },
    {
      'username': 'Adeyori',
      'images': ['./assets/images/bg.png'],
      'followers': 230,
      'following': 379,
      'about':
          'Talks about #technology, #programming, #webdevelopment, and #mobiledevelopment',
      'address': 'University of Lagos, Unilag\n Nigeria.',
      'professions': ['Software developer', 'Sells Robots']
    },
    {
      'username': 'Adeyori',
      'images': ['./assets/images/bg.png'],
      'followers': 230,
      'following': 379,
      'about':
          'Talks about #technology, #programming, #webdevelopment, and #mobiledevelopment',
      'address': 'University of Lagos, Unilag\n Nigeria.',
      'professions': ['Software developer', 'Sells Robots']
    },
    {
      'username': 'Adeyori',
      'images': ['./assets/images/bg.png'],
      'followers': 230,
      'following': 379,
      'about':
          'Talks about #technology, #programming, #webdevelopment, and #mobiledevelopment',
      'address': 'University of Lagos, Unilag\n Nigeria.',
      'professions': ['Software developer', 'Sells Robots']
    },
    {
      'username': 'Adeyori',
      'images': ['./assets/images/bg.png'],
      'followers': 230,
      'following': 379,
      'about':
          'Talks about #technology, #programming, #webdevelopment, and #mobiledevelopment',
      'address': 'University of Lagos, Unilag\n Nigeria.',
      'professions': ['Software developer', 'Sells Robots']
    }
  ];

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
    for (var post in postsMap) {
      posts.add(Post(
          images: post['images'],
          text: 'hello world',
          username: post['username']));
    }

    return posts;
  }

  // getting the logged in user's profile info
  Future<UserProfile> getProfile() async {
    GraphQLConfiguration _client = GraphQLConfiguration();
    QueryMutation _queryMutation = QueryMutation();
    UserProfile userProfile;

    String email = _client.box.get('myEmail'); // gets the logged user's email

    var result = await _client
        .clientToQuery()
        .query(QueryOptions(document: gql(_queryMutation.userInfo(email))));
    if (result.data!['getUser'] != null) {
      var data = result.data!['getUser'];
      return UserProfile(
        username: data['username'],
        about: data['profile']['about'],
        address: 'University road, Akoka\nNigeria',
        followers: data['profile']['followers'],
        following: data['profile']['following'],
        professions: ['', ''],
        profileImage: './assets/images/bg.png',
      );
    } else {
      return UserProfile(
          about: '',
          address: '',
          followers: 0,
          username: '',
          profileImage: '',
          following: 0,
          professions: ['']);
    }
  }
}

int hea() {
  if (9 == 0) {
    return 0;
  } else {
    return 1;
  }
}
