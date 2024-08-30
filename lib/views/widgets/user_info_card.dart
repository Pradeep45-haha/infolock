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
    double currentWidth = maxWidth > 300 ? 300 : maxWidth ;

    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          Container(
            constraints:
                BoxConstraints(maxWidth: currentWidth),
            margin: const EdgeInsets.only(top: 120),
            padding: const EdgeInsets.only(top: 160),
            decoration: BoxDecoration(
              color: Colors.yellowAccent[100],
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
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
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
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
              ],
            ),
          ),
          Positioned(
            left: currentWidth/2-120,
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
