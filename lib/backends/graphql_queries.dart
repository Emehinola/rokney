// for sending queries for the authentications

class QueryMutation {
  String register(String email, String username, String password) {
    // for registering user
    return """
      mutation{
        register(
          email: "$email",
          username: "$username",
          password1: "$password",
          password2: "$password"
        ){
          success,
          errors,
          token
        }
      }
    """;
  }

  // for authenticating users
  String authenticate(String email, String password) {
    return """
      mutation{
        tokenAuth(
          email: "$email",
          password: "$password"
        ){
          token,
          errors,
          success
        }
      }
    """;
  }

  // logging user in
  String login() {
    return """
      mutation logMeIn(\$username: String!, \$password: String!) {
        login (
          userData: {
            username: \$username,
            password: \$password
          }
        ){
          errors
          success,
          user{
            username
            email
          }
        }
      }
    """;
  }

  // for logging out
  String logout() {
    return """
      query{
        logout
      }
    """;
  }

  //query logged in user by his/her email
  String userInfo(String email) {
    return """
      query{
        getUser(email: "$email"){
          username,
          email,
          profile{
            following,
            followers,
            imageUrl,
            about,
            address,
            professions,
            verifiedUser,
            bio
          }
        }
      }
    """;
  }

  // profile creation
  String createProfile(String email) {
    return """
      mutation {
        createProfile(
          profileInput: {userEmail: "$email", bio: "About me", followers: 0, following: 0}
          ){
        success
        errors
            }
         }
    """;
  }

  // bio = graphene.String()
  //   about = graphene.String(required=False)
  //   address = graphene.String()
  //   professions = graphene.String()
  //   verified_user = graphene.Boolean(default=False)
  //   followers = graphene.Int()
  //   following = graphene.Int()

  // profile update mutation
  String updateProfile() {
    return """
      mutation updateMyProfile(\$userEmail: String!, \$bio: String, \$about: String, \$professions: String, \$username: String, \$address: String, \$profilePic: Upload){
        updateProfile(profileUpdateInput: {userEmail: \$userEmail, bio: \$bio, about: \$about, professions: \$professions, username: \$username, address: \$address, profilePic: \$profilePic}){
          success
          error
        }
      }
    """;
  }

  // getting posts related queries

  // create post
  String createPost() {
    return """
      mutation createPost(\$userEmail: String!, \$content: String, \$subtitle:String, \$images: [Upload!]){
        createPost(post: {userEmail: \$userEmail, content: \$content, subtitle: \$subtitle, images: \$images}){
          success
          error
        }
      }
    """;
  }

// all posts
  String getPosts() {
    return """
    query getPosts{
      posts{
        id
        content
        subtitle
        commentSet{
          id
        }
        likeSet{
          user{
            email
            username
          }
          liked
          post{
            content
          }
        }
        user{
          username
          email
          profile{
            verifiedUser
            imageUrl
          }
        }
        filealbumSet{
          images
          imageUrl
        }
      }
    }
  """;
  }

  // comments query
  String getComment() {
    return """
      query getComments(\$postId: Int!){
        comments(postId: \$postId){
          post{
            content
          }
          content
          time
          user{
            username
            profile{
              imageUrl
            }
          }
        }
      }
    """;
  }

  // creating comment
  String createComment() {
    return """
      mutation createCommentForPost(\$content: String!, \$email: String!, \$postId: Int){
        createComment(comment: {content: \$content, email: \$email, postId: \$postId}){
          success
          error
        }
      }
    """;
  }

  // creating post like
  String createLike() {
    return """
      mutation createLike(\$postId: Int!, \$userEmail: String!){
        createLike(like: {postId: \$postId, userEmail: \$userEmail}){
          success
          error
  }
}
    """;
  }
}
