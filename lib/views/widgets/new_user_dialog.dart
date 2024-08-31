import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:infolock/models/user_info.dart';
import 'package:infolock/themes.dart';
import 'package:infolock/viewmodels/state_management/user_data_provider.dart';
import 'package:provider/provider.dart';

class NewUserDialog extends StatelessWidget {
  final UserInfo? userInfoToEdit;
  const NewUserDialog({super.key, this.userInfoToEdit});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: NewUserForm(
        userInfoToEdit: userInfoToEdit,
      ),
    );
  }
}

class NewUserForm extends StatefulWidget {
  final UserInfo? userInfoToEdit;
  const NewUserForm({super.key, this.userInfoToEdit});

  @override
  State<NewUserForm> createState() => _NewUserFormState();
}

class _NewUserFormState extends State<NewUserForm> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController phoneNumberController;
  Uint8List? userImage;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    ageController = TextEditingController();
    phoneNumberController = TextEditingController();
    if (widget.userInfoToEdit != null) {
      nameController.text = widget.userInfoToEdit!.name;
      ageController.text = widget.userInfoToEdit!.age.toString();
      phoneNumberController.text =
          widget.userInfoToEdit!.numbers!.first.toString();
      if (widget.userInfoToEdit!.image != null) {
        context
            .read<UserDataProvider>()
            .addImage(widget.userInfoToEdit!.image!);
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 12),
            height: 48,
            decoration: const BoxDecoration(
              color: Colors.purple,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Add new person info",
                style: titleTextStyle,
              ),
            ),
          ),
          context.watch<UserDataProvider>().editMode
              ? context.watch<UserDataProvider>().currentProfileImage == null
                  ? const AddImage()
                  : UserProfile(
                      userImage:
                          context.watch<UserDataProvider>().currentProfileImage)
              : (context.watch<UserDataProvider>().currentProfileImage != null
                  ? UserProfile(
                      userImage:
                          context.watch<UserDataProvider>().currentProfileImage)
                  : const AddImage()),
          Padding(
            padding: primaryPadding.copyWith(top: 36),
            child: TextFormField(
              controller: nameController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: textFormFieldBorderRadius,
                ),
                label: Text("Full Name"),
                hintText: "Enter Full Name",
              ),
            ),
          ),
          Padding(
            padding: primaryPadding,
            child: TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: textFormFieldBorderRadius,
                ),
                label: Text("Age"),
                hintText: "Enter Age",
              ),
            ),
          ),
          Padding(
            padding: primaryPadding.copyWith(bottom: 36),
            child: TextFormField(
              controller: phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: textFormFieldBorderRadius,
                ),
                label: Text("Phone Number"),
                hintText: "Enter Phone Number",
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        ageController.text.isNotEmpty &&
                        phoneNumberController.text.isNotEmpty) {
                      UserInfo userInfo = UserInfo(
                        age: int.parse(ageController.text),
                        name: nameController.text,
                        numbers: [
                          int.parse(phoneNumberController.text),
                        ],
                        
                      );
                      if (context.read<UserDataProvider>().editMode) {
                        context.read<UserDataProvider>().editUser(
                            context.read<UserDataProvider>().editingUserIdx!,
                            userInfo);
                            Navigator.of(context).pop();
                            return;
                      }
                      context.read<UserDataProvider>().addUser(userInfo);
                      Navigator.of(context).pop();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      context.watch<UserDataProvider>().editMode
                          ? "Update"
                          : "Add",
                      style: const TextStyle(
                        color: Colors.purple,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class AddImage extends StatelessWidget {
  const AddImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Add Profile Picture"),
        IconButton(
          onPressed: () {
            context.read<UserDataProvider>().pickImage();
          },
          icon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.add),
          ),
        )
      ],
    );
  }
}

class UserProfile extends StatelessWidget {
  const UserProfile({
    super.key,
    required this.userImage,
  });

  final Uint8List? userImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 160,
          backgroundImage: MemoryImage(
            userImage!,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            onPressed: () {
              context.read<UserDataProvider>().removeImage();
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
