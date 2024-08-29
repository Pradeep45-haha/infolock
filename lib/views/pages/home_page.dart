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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text(
          "Personal Info",
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
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: ListView.builder(
                  itemCount: context.watch<UserDataProvider>().usersInfo.length,
                  itemBuilder: (context, index) {
                    UserInfo userInfo =
                        context.watch<UserDataProvider>().usersInfo[index];
                    return UserInfoCard(userInfo: userInfo);
                  },
                ),
              ),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: IconButton(
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
