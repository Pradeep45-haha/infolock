import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:infolock/models/user_info.dart';
// import 'package:infolock/themes.dart';

class UserInfoCard extends StatelessWidget {
  final UserInfo userInfo;
  const UserInfoCard({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Text(
                  userInfo.name,
                  style: const TextStyle(
                    fontSize: 36.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "${userInfo.age.toString()} years old",
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                Container(
                  decoration: const BoxDecoration(color: Colors.purple),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: const Icon(
                          FontAwesomeIcons.instagram,
                        ),
                      ),
                      IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.facebook),
                      ),
                      IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.linkedin),
                      ),
                      IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.github),
                      ),
                      IconButton(
                        color: Colors.white,
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.whatsapp),
                      ),
                    ],
                  ),
                ),
                userInfo.image != null
                    ? CircleAvatar(
                        maxRadius: 64,
                        minRadius: 24,
                        child: Image.memory(userInfo.image!),
                      )
                    : const SizedBox(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
