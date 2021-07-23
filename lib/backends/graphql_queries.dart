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
  String login(String email_or_username, String password) {
    return """
      mutation {
        login(
          userData: {
            username: "$email_or_username",
            password: "$password"
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
      mutation updateMyProfile(\$userEmail: String!, \$bio: String!, \$about: String!, \$professions: String!, \$username: String!, \$address: String!){
        updateProfile(profileUpdateInput: {userEmail: \$userEmail, bio: \$bio, about: \$about, professions: \$professions, username: \$username, address: \$address}){
          success
          error
        }

      }
    """;
  }
}
