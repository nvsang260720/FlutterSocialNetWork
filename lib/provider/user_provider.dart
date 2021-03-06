import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:test/api/api_url.dart';
import 'package:test/models/user.dart';
import 'package:test/models/users.dart';

// ignore_for_file: type=lint
class UserProvider extends ChangeNotifier {
  User _user = User();
  User get user => this._user;

  void setUser(User user) {
    _user = user;
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   notifyListeners();
    //   // Add Your Code here.
    // });
  }

  notifyListeners();
  List<Users> listUser = [];
  Future<List<Users>> getAllUser() async {
    List<Users> listNewUser = [];
    Response response = await get(Uri.parse(ApiUrl.getAllUser));
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      for (Map i in responseData['data']) {
        if (i['_id'] == _user.iduser) continue;
        Users user = await Users(
            avatarImage: i['avatar'],
            iduser: i['_id'],
            username: i['username']);
        listNewUser.add(user);
        listUser = listNewUser;
      }
      notifyListeners();
      return listUser;
    } else {
      throw Exception('Failed to load.');
    }
  }

  get getAllUserList {
    return listUser;
  }

  List<Users> listUserForUser = [];
  Future<List<Users>> getAllUserForUser() async {
    List<Users> listNewUserForUser = [];
    Response response = await get(Uri.parse(ApiUrl.getAllUser));
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      for (Map i in responseData['data']) {
        for (String p in i['followers']) {
          if (p != _user.iduser) continue;
          Users user = await Users(
              avatarImage: i['avatar'],
              iduser: i['_id'],
              username: i['username']);
          listNewUserForUser.add(user);
        }
        listUserForUser = listNewUserForUser;
      }
      notifyListeners();
      return listUserForUser;
    } else {
      throw Exception('Failed to load.');
    }
  }

  get clearAllUserForUserList {
    return listUserForUser.clear();
  }

  get getAllUserForUserList {
    return listUserForUser;
  }

  void notify() {
    notifyListeners();
  }

  User? userF;
  Future<User> getUser(String token, String id) async {
    Response response = await get(Uri.parse(ApiUrl.profileUrl + id),
        headers: {'Authorization': 'Bearer ' + token});

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      userF = User(
        iduser: responseData['data']['_id'],
        about: responseData['data']['about'],
        address: responseData['data']['address'],
        avatarImage: responseData['data']['avatar'],
        birthday: responseData['data']['birthday'],
        coverImage: responseData['data']['cover'],
        gender: responseData['data']['gender'],
        token: responseData['token'],
        username: responseData['data']['username'],
        followers: List<String>.from(responseData['data']['followers']),
        following: List<String>.from(responseData['data']['following']),
      );

      notifyListeners();
      return userF!;
    } else {
      throw Exception('Failed to load.');
    }
  }

  get clearUserInfo {
    return userF = null;
  }

  get friendInfo {
    return userF;
  }

  List<String> images = [];

  Future<void> getImages(String id) async {
    final response = await get(Uri.parse(ApiUrl.getTotalImage + id), headers: {
      'Authorization': 'Bearer ' + _user.token!,
      'Content-Type': 'application/json'
    });

    if (response.statusCode == 200) {
      print('ok');
      List<dynamic> responseData = json.decode(response.body)['urls'];
      images = List<String>.from(responseData);
      notifyListeners();
    } else {
      print("getTotal ${response.statusCode}");
    }
  }

  get clearImages {
    return images.clear();
  }

  get listImages {
    return images;
  }
}
