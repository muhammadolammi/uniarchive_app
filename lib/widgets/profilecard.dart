import 'package:flutter/material.dart';
import 'package:uniarchive/models.dart';

class Profilecard extends StatelessWidget {
  final User user;
  const Profilecard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 180,
      // color: Colors.red,
      decoration: BoxDecoration(
        color: Colors.blue, // Background color of the container
        border: Border.all(
          color: Colors.blue, // Border color
          width: 2, // Border width
        ),
        borderRadius: BorderRadius.circular(10), // Rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, top: 5),
                child: user!.profileUrl.isNotEmpty
                    ? CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(user.profileUrl),
                      )
                    : const CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                children: [Text("${user.firstName} ${user.lastName} ")],
              ),
            ],
          )
        ],
      ),
    );
  }
}
