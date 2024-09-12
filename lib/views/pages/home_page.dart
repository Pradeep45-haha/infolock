import 'package:flutter/material.dart';
import 'package:infolock/models/user_info.dart';
import 'package:infolock/viewmodels/state_management/state.dart';
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
        Provider.of<UserDataProvider>(context, listen: false);
    UserDataProvider listenUserDataProvider =
        Provider.of<UserDataProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: actionButton1(context),
          ),
        ],
        backgroundColor: Colors.purple,
        title: appTitle(listenUserDataProvider),
        centerTitle: true,
      ),
      body: listenUserDataProvider.appState == AppState.loading
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
                itemCount: listenUserDataProvider.usersInfo.length,
                itemBuilder: (context, index) {
                  UserInfo userInfo = listenUserDataProvider.usersInfo[index];
                  return GestureDetector(
                    onLongPress: () {
                      userDataProvider.toogleDeleteMode();
                      userDataProvider.addUserToDelete(index);
                    },
                    onTap: () {
                      if (userDataProvider.appState == AppState.deleting) {
                        if (userDataProvider.userToDelete.contains(index)) {
                          userDataProvider.removeUserFromDelete(index);
                        } else {
                          userDataProvider.addUserToDelete(index);
                        }
                      }
                      if (userDataProvider.appState == AppState.editing) {
                        userDataProvider.setEditingUserIdx(index);
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
      floatingActionButton: floatingIconButton(context),
    );
  }

  IconButton actionButton1(BuildContext context) {
    return IconButton(
      iconSize: 28,
      hoverColor: Colors.lightGreen,

      onPressed: () {
        context.read<UserDataProvider>().toogleEditMode();
      },
      icon: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
    );
  }

  Text appTitle(UserDataProvider listenUserDataProvider) {
    String title = "";
    if (listenUserDataProvider.appState == AppState.editing) {
      title = "Edit Mode";
    } else if (listenUserDataProvider.appState == AppState.deleting) {
      title = "Delete Mode";
    } else {
      title = "Personal Info";
    }
    return Text(
      title,
      style: titleTextStyle,
    );
  }

  Widget? floatingIconButton(BuildContext context) {
    UserDataProvider userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    UserDataProvider listenUserDataProvider =
        Provider.of<UserDataProvider>(context, listen: true);

    onPressedCallback() {
      if (userDataProvider.appState == AppState.loaded) {
        showDialog(
          context: context,
          builder: (context) {
            return const NewUserDialog();
          },
        );
      } else if (userDataProvider.appState == AppState.deleting) {
        userDataProvider.deleteUser();
      }
    }

    if (listenUserDataProvider.appState == AppState.deleting) {
      return IconButton(
        style: floatingButtonStyle,
        onPressed: onPressedCallback,
        icon: const Icon(
          Icons.delete,
          size: floatingIconSize,
          color: floatingIconColor,
        ),
      );
    } else if (listenUserDataProvider.appState == AppState.loaded) {
      return IconButton(
        style: floatingButtonStyle,
        onPressed: onPressedCallback,
        icon: const Icon(
          Icons.add,
          size: floatingIconSize,
          color: floatingIconColor,
        ),
      );
    }
    return null;
  }
}
