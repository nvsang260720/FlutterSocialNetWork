class User {
  String? username;
  String? token;
  String? iduser;
  String? about;
  String? address;
  String? birthday;
  int? gender;
  String? coverImage;
  String? avatarImage;

  User(
      {this.username,
      this.token,
      this.iduser,
      this.about,
      this.gender,
      this.address,
      this.birthday,
      this.avatarImage,
      this.coverImage});
  factory User.fromJson(Map<String, dynamic> responseData, String token) {
    return User(
      username: responseData['data']['username'],
      token: responseData['token'],
      gender: responseData['data']['gender'],
      iduser: responseData['data']['_id'],
      about: responseData['data']['about'],
      address: responseData['data']['address'],
      birthday: responseData['data']['birthday'],
      avatarImage: responseData['data']['avatar'],
      coverImage: responseData['data']['cover'],
    );
  }
}
