import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/BottomAppBar_Controller/ProfileController.dart';
import '../../../Utils/constant.dart';

// class ProfileScreen extends StatelessWidget {
//   ProfileController profileController = Get.put(ProfileController());
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       maintainBottomViewPadding: true,
//       minimum: const EdgeInsets.all(8),
//       child: Scaffold(
//         body: Obx(
//               () => Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: ListView.builder(
//               itemCount: profileController.profileList.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   elevation: 5,
//                   child: ListTile(
//                     title: Row(
//                       children: [
//                         const Icon(Icons.person_add),
//                         const SizedBox(width: 10,),
//                         Text(profileController.profileList[index]),
//                       ],
//                     ),
//                     trailing: IconButton(
//                       onPressed: () {},
//                       icon: const Icon(Icons.navigate_next_outlined),
//                     ),
//                     // You can add more properties or functionalities to the list tile if needed
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const ProfileHeader(
                title: "Ramesh Mana",
                subtitle: "Manager",
              ),
              const SizedBox(height: 10.0),
              const UserInfo(),
              const Divider(
                thickness: 1,
              ),
              SizedBox(
                height: 150,
                child: Obx(
                      () => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: profileController.profileList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            if(index==0){
                              Get.toNamed(ROUTE_MANAGEUSERLIST);
                            }
                          },
                          child: Card(
                            elevation: 5,
                            child: ListTile(
                              title: Row(
                                children: [
                                  const Icon(Icons.person_add),
                                  const SizedBox(width: 10,),
                                  Text(profileController.profileList[index]),
                                ],
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.navigate_next_outlined),
                              ),
                              // You can add more properties or functionalities to the list tile if needed
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
            alignment: Alignment.topLeft,
            child: const Text(
              "User Information",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Card(
            child: Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      ...ListTile.divideTiles(
                        color: Colors.grey,
                        tiles: [
                          // const ListTile(
                          //   contentPadding: EdgeInsets.symmetric(
                          //       horizontal: 12, vertical: 4),
                          //   leading: Icon(Icons.my_location),
                          //   title: Text("Location"),
                          //   subtitle: Text("Kathmandu"),
                          // ),
                          const ListTile(
                            leading: Icon(Icons.email),
                            title: Text("Email"),
                            subtitle: Text("vignesh@gmail.com"),
                          ),
                          const ListTile(
                            leading: Icon(Icons.password_sharp),
                            title: Text("Password"),
                            subtitle: Text("********"),
                          ),
                          // const ListTile(
                          //   leading: Icon(Icons.person),
                          //   title: Text("About Me"),
                          //   subtitle: Text(
                          //       "This is a about me link and you can khow about me in this section."),
                          // ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;

  const ProfileHeader(
      {Key? key,
        required this.title,
        this.subtitle,
        this.actions})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // Ink(
        //   height: 200,
        //   decoration: BoxDecoration(
        //     image: DecorationImage(
        //         image: coverImage as ImageProvider<Object>, fit: BoxFit.cover),
        //   ),
        // ),
        // Ink(
        //   height: 200,
        //   decoration: const BoxDecoration(
        //     color: Colors.black38,
        //   ),
        // ),
        // if (actions != null)
        //   Container(
        //     width: double.infinity,
        //     height: 200,
        //     padding: const EdgeInsets.only(bottom: 0.0, right: 0.0),
        //     alignment: Alignment.bottomRight,
        //     child: Row(
        //       mainAxisSize: MainAxisSize.min,
        //       children: actions!,
        //     ),
        //   ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              // Avatar(
              //   image: avatar,
              //   radius: 40,
              //   backgroundColor: Colors.white,
              //   borderColor: Colors.grey.shade300,
              //   borderWidth: 4.0,
              // ),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 5.0),
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ]
            ],
          ),
        )
      ],
    );
  }
}

class Avatar extends StatelessWidget {
  final ImageProvider<dynamic> image;
  final Color borderColor;
  final Color? backgroundColor;
  final double radius;
  final double borderWidth;

  const Avatar(
      {Key? key,
        required this.image,
        this.borderColor = Colors.grey,
        this.backgroundColor,
        this.radius = 30,
        this.borderWidth = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius + borderWidth,
      backgroundColor: borderColor,
      child: CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        child: CircleAvatar(
          radius: radius - borderWidth,
          backgroundImage: image as ImageProvider<Object>?,
        ),
      ),
    );
  }
}