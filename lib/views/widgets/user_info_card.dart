import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infolock/models/user_info.dart';
// import 'package:infolock/themes.dart';

class UserInfoCard extends StatelessWidget {
  final UserInfo userInfo;
  const UserInfoCard({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    double maxWidth = MediaQuery.of(context).size.width;
    double currentWidth = maxWidth > 300 ? 300 : maxWidth;

    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: currentWidth),
            margin: const EdgeInsets.only(top: 140),
            padding: const EdgeInsets.only(top: 120),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.purple, width: 2),
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
                    decoration: const BoxDecoration(
                      color: Colors.purple,
                      borderRadius: BorderRadius.only(
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
          Positioned(
            left: (currentWidth / 2) - 120,
            child: userInfo.image != null
                ? Material(
                    elevation: 8,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(120),
                    ),
                    shadowColor: Colors.purple,
                    child: CircleAvatar(
                      radius: 120,
                      backgroundImage: MemoryImage(
                        userInfo.image!,
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ],
      ),
    );
  }
}
