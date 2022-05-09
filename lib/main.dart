// ignore_for_file: type=lint
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:test/models/user.dart';
import 'package:test/preference/user_peference.dart';
import 'package:test/provider/auth_provider.dart';
import 'package:test/provider/user_provider.dart';

import 'package:test/screens/auth/login_page.dart';
import 'package:test/screens/posts/new_post.dart';
import 'package:test/screens/profile_friend_page.dart';

import 'package:test/screens/top_navigation.dart';

//Test
void main() {
  runApp(const MyApp());
}

//tesss
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Future<User> getUserData() => UserPreference().getUser();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: FutureBuilder(
            future: getUserData(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return CircularProgressIndicator();
                default:
                  if (snapshot.hasError) {
                    return Text('Error:${snapshot.error}');
                  } else if ((snapshot.data as dynamic).token == null) {
                    return LoginPage();
                  } else {
                    Provider.of<UserProvider>(context)
                        .setUser(snapshot.data as dynamic);
                    return NavigationBarSC();
                  }
              }
            },
          )),
    );
  }
}
