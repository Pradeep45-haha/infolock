import 'package:flutter/material.dart';
import 'package:infolock/models/user_info.dart';
import 'package:infolock/viewmodels/state_management/user_data_provider.dart';
import 'package:infolock/views/widgets/new_user_dialog.dart';
import 'package:infolock/views/widgets/user_info_card.dart';
import 'package:provider/provider.dart';
import '../../themes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    UserDataProvider userDataProvider =
        Provider.of<UserDataProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: IconButton(
              iconSize: 28,
              hoverColor: Colors.lightGreen,
              onPressed: () {
                context.read<UserDataProvider>().toogleEditMode();
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.purple,
        title: Text(
          context.watch<UserDataProvider>().editMode == true
              ? "Edit Mode"
              : "Personal Info",
          style: titleTextStyle,
        ),
        centerTitle: true,
      ),
      body: context.watch<UserDataProvider>().gettingData == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.purple,
              ),
            )
          : Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: context.watch<UserDataProvider>().usersInfo.length,
                itemBuilder: (context, index) {
                  UserInfo userInfo =
                      context.watch<UserDataProvider>().usersInfo[index];
                  return GestureDetector(
                    onLongPress: () {
                      userDataProvider.toogleDeleteMode();
                      userDataProvider.addUserToDelete(index);
                    },
                    onTap: () {
                      if (userDataProvider.deleteMode) {
                        if (userDataProvider.userToDelete.contains(index)) {
                          userDataProvider.removeUserFromDelete(index);
                          return;
                        } else {
                          userDataProvider.addUserToDelete(index);
                          return;
                        }
                      }
                      if (context.read<UserDataProvider>().editMode) {
                        context
                            .read<UserDataProvider>()
                            .setEditingUserIdx(index);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return NewUserDialog(
                              userInfoToEdit: userInfo,
                            );
                          },
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                        bottom: 12,
                      ),
                      child: UserInfoCard(
                        userInfo: userInfo,
                        key: ValueKey(index),
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: context.watch<UserDataProvider>().editMode
          ? null
          : IconButton(
              style: floatingButtonStyle,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const NewUserDialog();
                  },
                );
              },
              icon: const Icon(
                Icons.add,
                size: floatingIconSize,
                color: floatingIconColor,
              ),
            ),
    );
  }
}
