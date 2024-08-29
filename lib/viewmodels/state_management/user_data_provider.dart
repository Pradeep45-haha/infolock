import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:infolock/core/custom_exception.dart';
import 'package:infolock/models/user_info.dart';
import 'package:infolock/repositories/user_repositories.dart';

class UserDataProvider extends ChangeNotifier {
  final UserRepository _userRepository;
  final ImageRepository _imageRepository;
  UserDataProvider(
      {required UserRepository userRepository,
      required ImageRepository imageRepository})
      : _userRepository = userRepository,
        _imageRepository = imageRepository;

  //
  List<UserInfo> usersInfo = [];
  bool gettingData = false;
  Uint8List? currentProfileImage;

  getAllUsers() async {
    try {
      gettingData = true;
      notifyListeners();
      List<UserInfo>? newUserInfoList = await _userRepository.getUsers();
      newUserInfoList != null ? usersInfo = (newUserInfoList) : null;
    } catch (e) {
      if (e is OperationFailed) {
        debugPrint(
            "exception OperationFailed from UserDataProvider getAllUsers=> ${e.message.toString()}");
        return;
      }
      debugPrint(
          "exception from UserDataProvider getAllUsers=> ${e.toString()}");
    }
    gettingData = false;
    notifyListeners();
  }

  addUser(UserInfo userInfo) async {
    try {
      gettingData = true;
      notifyListeners();
      debugPrint("from UserDataProvide method addUser");
      if (currentProfileImage != null) {
        userInfo.image = currentProfileImage!;
        currentProfileImage = null;
      }
      await _userRepository.addUser(userInfo);
      await getAllUsers();
    } catch (e) {
      if (e is OperationFailed) {
        debugPrint(
            "exception from UserDataProvider addUser=> ${e.message.toString()}");
        return;
      }
      debugPrint("exception from UserDataProvider addUser=> ${e.toString()}");
    }
    gettingData = false;
    notifyListeners();
  }

  pickImage() async {
    try {
      Uint8List? profileImage = await _imageRepository.getImage();
      if (profileImage != null) {
        debugPrint(
            "from UserDataProvider methos pickImage user picked profile image");
      } else {
        debugPrint(
            "from UserDataProvider methos pickImage user did not pick profile image");
      }
      if (profileImage != null) {
        notifyListeners();
      }
      currentProfileImage = profileImage;
    } catch (e) {
      debugPrint("from UserDataProvider method pickImage => ${e.toString()}");
    }
  }
}
