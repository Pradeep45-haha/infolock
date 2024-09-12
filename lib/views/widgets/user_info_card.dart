import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infolock/models/user_info.dart';
import 'package:infolock/viewmodels/state_management/state.dart';
import 'package:infolock/viewmodels/state_management/user_data_provider.dart';
import 'package:provider/provider.dart';

const selectedBorderColor = Colors.red;
const deSelectedBorderColor = Colors.purple;

class UserInfoCard extends StatelessWidget {
  final UserInfo userInfo;
  const UserInfoCard({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    Color? borderColor;
    List<String> val = key.toString().split("[<");
    val = val[1].split(">]");
    int keyVal = int.parse(val[0]);
    UserDataProvider userDataProvider =
        Provider.of<UserDataProvider>(context, listen: true);
    if (userDataProvider.appState == AppState.deleting) {
      if (userDataProvider.userToDelete.contains(keyVal)) {
        borderColor = selectedBorderColor;
      } else {
        borderColor = deSelectedBorderColor;
      }
    } else {
      borderColor = deSelectedBorderColor;
    }
    double maxWidth = MediaQuery.of(context).size.width;
    double currentWidth = maxWidth > 300 ? 300 : maxWidth;
    double topConatinerPadding = userInfo.image == null ? 0.0 : 120.0;

    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: currentWidth),
            margin: EdgeInsets.only(top: topConatinerPadding + 20),
            padding: EdgeInsets.only(top: topConatinerPadding),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor, width: 2),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
                topLeft: Radius.circular(36),
                topRight: Radius.circular(36),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    userInfo.name,
                    style: const TextStyle(
                      fontSize: 36.0,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 8.0, top: 0, left: 8, right: 8),
                  child: Text(
                    "${userInfo.age.toString()} years old",
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: borderColor,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: IconButton(
                            iconSize: 32,
                            color: Colors.white,
                            onPressed: () {},
                            icon: const Icon(
                              FontAwesomeIcons.instagram,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: IconButton(
                            iconSize: 32,
                            color: Colors.white,
                            onPressed: () {},
                            icon: const Icon(FontAwesomeIcons.facebook),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: IconButton(
                            iconSize: 32,
                            color: Colors.white,
                            onPressed: () {},
                            icon: const Icon(FontAwesomeIcons.linkedin),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: IconButton(
                            iconSize: 32,
                            color: Colors.white,
                            onPressed: () {},
                            icon: const Icon(FontAwesomeIcons.github),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: IconButton(
                            iconSize: 32,
                            color: Colors.white,
                            onPressed: () {},
                            icon: const Icon(FontAwesomeIcons.whatsapp),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          userInfo.image != null
              ? Positioned(
                  left: (currentWidth / 2) - 120,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 4,
                            blurStyle: BlurStyle.normal,
                            color: borderColor,
                            spreadRadius: 0.1)
                      ],
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: borderColor,
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 120,
                      backgroundImage: MemoryImage(
                        userInfo.image!,
                      ),
                    ),
                  ))
              : const SizedBox()
        ],
      ),
    );
  }
}
