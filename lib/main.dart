import 'package:flutter/material.dart';
import 'package:infolock/models/user_info.dart';
import 'package:infolock/repositories/user_repositories.dart';
import 'package:infolock/services/local_user.dart';
import 'package:infolock/viewmodels/state_management/user_data_provider.dart';
import 'package:infolock/views/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserInfoAdapter());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserDataProvider(
        imageRepository: ImageRepository(
          filePickerService: FilePickerService(),
        ),
        userRepository: UserRepository(
          localService: LocalService(),
        ),
      )..getAllUsers(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: HomePage(),
      ),
    );
  }
}
