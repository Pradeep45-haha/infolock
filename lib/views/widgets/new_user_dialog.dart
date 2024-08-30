import 'package:flutter/material.dart';
import 'package:infolock/models/user_info.dart';
import 'package:infolock/themes.dart';
import 'package:infolock/viewmodels/state_management/user_data_provider.dart';
import 'package:provider/provider.dart';

class NewUserDialog extends StatelessWidget {
  const NewUserDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      child: NewUserForm(),
    );
  }
}

class NewUserForm extends StatefulWidget {
  const NewUserForm({super.key});

  @override
  State<NewUserForm> createState() => _NewUserFormState();
}

class _NewUserFormState extends State<NewUserForm> {
  late TextEditingController nameController;
  late TextEditingController ageController;
  late TextEditingController phoneNumberController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    ageController = TextEditingController();
    phoneNumberController = TextEditingController();
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
          context.watch<UserDataProvider>().currentProfileImage != null
              ? Column(
                  children: [
                    CircleAvatar(
                      radius: 160,
                      backgroundImage: MemoryImage(
                        context.watch<UserDataProvider>().currentProfileImage!,
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
                          )),
                    )
                  ],
                )
              : Row(
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
                ),
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
                      context.read<UserDataProvider>().addUser(
                            UserInfo(
                              age: int.parse(ageController.text),
                              name: nameController.text,
                              numbers: [
                                int.parse(phoneNumberController.text),
                              ],
                            ),
                          );
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Add",
                      style: TextStyle(
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
