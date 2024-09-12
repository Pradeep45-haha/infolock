import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:infolock/core/custom_exception.dart';
import 'package:infolock/models/user_info.dart';
import 'package:infolock/repositories/user_repositories.dart';
import 'package:infolock/viewmodels/state_management/state.dart';

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
  List<int> userToDelete = [];

  Uint8List? currentProfileImage;
  bool deleteAllUser = false;

  int? editingUserIdx;
  AppState appState = AppState.adding;

  changeStateTo(AppState state) {
    if (!(appState == state)) {
      if (appState == AppState.deleting && appState != state) {
        userToDelete.clear();
      }
      appState = state;
      notifyListeners();
    }
  }

  getAllUsers() async {
    try {
      changeStateTo(AppState.loading);
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

    changeStateTo(AppState.loaded);
  }

  addUser(UserInfo userInfo) async {
    try {
      changeStateTo(AppState.loading);

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
    changeStateTo(AppState.loaded);
  }

  editUser(int index, UserInfo newUserInfo) async {
    try {
      if (index > usersInfo.length - 1) {
        throw NoSuchUserTile();
      }
      newUserInfo.image = currentProfileImage;
      currentProfileImage = null;
      await _userRepository.updateUser(newUserInfo, index);
      await getAllUsers();
    } catch (e) {
      debugPrint("exception from edit user => ${e.toString()}");
    }
    editingUserIdx = null;
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

  setEditMode(bool mode) {
    if (usersInfo.isNotEmpty) {
      changeStateTo(AppState.editing);
    }
  }

  toogleEditMode() {
    if (usersInfo.isNotEmpty) {
      if (appState == AppState.editing) {
        changeStateTo(AppState.loaded);
      } else {
        changeStateTo(AppState.editing);
      }
    }
  }

  removeImage() {
    currentProfileImage = null;
    notifyListeners();
  }

  addImage(Uint8List image) {
    currentProfileImage = image;
  }

  setEditingUserIdx(int idx) {
    editingUserIdx = idx;
  }

  deleteUser() async {
    try {
      for (var element in userToDelete) {
        await _userRepository.deleteUser(element);
      }
      userToDelete = [];
      await getAllUsers();
    } catch (e) {
      debugPrint("from Userdataprovider method delete user => ${e.toString()}");
    }
    notifyListeners();
  }

  addUserToDelete(int idx) {
    userToDelete.add(idx);
    notifyListeners();
  }

  addAllUserToDelete(int idx) async {
    deleteAllUser = true;
    notifyListeners();
  }

  removeUserFromDelete(int idx) {
    userToDelete.remove(idx);
    if (userToDelete.isEmpty) {
      toogleDeleteMode();
    }
    notifyListeners();
  }

  toogleDeleteMode() {
    if (appState == AppState.deleting) {
      userToDelete.clear();
      changeStateTo(AppState.loaded);
    } else {
      changeStateTo(AppState.deleting);
    }
  }
}
