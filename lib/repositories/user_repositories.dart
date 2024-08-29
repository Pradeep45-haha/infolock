import 'dart:typed_data';

import 'package:infolock/models/user_info.dart';
import 'package:infolock/services/local.dart';

class UserRepository {
  final LocalService localService;
  UserRepository({required this.localService});
  Future<List<UserInfo>?> getUsers() async {
    try {
      return await localService.get();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addUser(UserInfo userInfo) async {
    try {
      await localService.add(userInfo);
    } catch (e) {
      rethrow;
    }
  }

  updateUser(UserInfo userInfo) {}

  deleteUser(UserInfo userInfo) {}

  deleteAllUser() {}
}

class ImageRepository {
  final FilePickerService filePickerService;
  ImageRepository({required this.filePickerService});
  Future<Uint8List?> getImage() async {
    try {
      Uint8List? image = await filePickerService.pickImage();
      return image;
    } catch (e) {
      rethrow;
    }
  }
}
