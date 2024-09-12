import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:infolock/core/custom_exception.dart';
import 'package:infolock/models/user_info.dart';

class LocalService {
  final String userInfoBox = "userInfoBox";
  // final String userInfoKey = "userKey";
  Box<UserInfo>? _userInfoBox;

  Future<void> _openBox() async {
    try {
      _userInfoBox ??= await Hive.openBox<UserInfo>(userInfoBox);
    } catch (e) {
      debugPrint("from service method _openBox => ${e.toString()}");
      throw OperationFailed(message: e.toString());
    }
  }

  Future<List<UserInfo>?> get() async {
    try {
      await _openBox();
      return _userInfoBox!.values.toList();
    } catch (e) {
      debugPrint("from service method get => ${e.toString()}");
      throw OperationFailed(message: e.toString());
    }
  }

  Future<void> add(UserInfo userInfo) async {
    debugPrint("from localService method add ${userInfo.toString()}");
    try {
      await _openBox();
      await _userInfoBox!.add(userInfo);
    } catch (e) {
      throw OperationFailed(message: e.toString());
    }
  }

  Future<void> delete(int index) async {
    try {
      await _openBox();
      await _userInfoBox!.deleteAt(index);
    } catch (e) {
      throw OperationFailed(message: e.toString());
    }
  }

  Future<void> deleteAll() async {
    try {
      await _openBox();
      await _userInfoBox!.clear();
    } catch (e) {
      throw OperationFailed(message: e.toString());
    }
  }

  Future<void> update(int index, UserInfo newUserInfo) async {
    try {
      await _openBox();
      await _userInfoBox!.putAt(index, newUserInfo);
    } catch (e) {
      throw OperationFailed(message: e.toString());
    }
  }
}

class FilePickerService {
  Future<Uint8List?> pickImage() async {
    try {
      FilePickerResult? imagePicked = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
      );
      if (imagePicked != null) {
        return imagePicked.files.first.bytes;
      }
      return null;
    } catch (e) {
      throw FilePickerException(message: e.toString());
    }
  }
}
