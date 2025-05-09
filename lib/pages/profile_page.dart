import 'package:flutter/material.dart';
import 'package:flutter_testing/widgets/profile_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isSelectedProject = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 50.0, top: 80.0, right: 50.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelectedProject = false;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      color: isSelectedProject ? Colors.grey : Colors.white,
                      border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Profile',
                      style: TextStyle(
                        color: isSelectedProject ? Colors.black : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSelectedProject = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      color: isSelectedProject ? Colors.white : Colors.grey,
                      border: Border.all(color: Colors.black),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Project',
                      style: TextStyle(
                        color: isSelectedProject ? Colors.black : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (isSelectedProject)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                margin: const EdgeInsets.only(
                  left: 50.0,
                  right: 50.0,
                  bottom: 80.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: GridView.builder(
                  itemCount: 12,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 4 / 5,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  itemBuilder: (context, index) {
                    return ProfileCard(
                      imageUrl:
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3jL6gUvfFslb4OCAOMuiKL7lnxRIByo-e5I_ub2RSdqmkMVCX1rOa6YcfFUXRcxTvOSY&usqp=CAU",
                      duration: "04:12",
                      name: "Project ${index + 1}",
                      description: "Describe: No describe",
                      likes: index * 2,
                      comments: index,
                    );
                  },
                ),
              ),
            )
          else
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 70),
                margin: const EdgeInsets.only(
                  left: 50.0,
                  right: 50.0,
                  bottom: 80.0,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Full name ",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Nguyen Van A",//TODO: Add data
                          style: TextStyle(
                              fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Divider(
                      color: Colors.black,
                      thickness: 3,
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                            "Email: ",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "nguyenvana@example.com",//TODO: Add data
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Divider(
                      color: Colors.black,
                      thickness: 3,
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                            "YY/MM/YYYY: ",
                          style: TextStyle(
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "01/01/2000",  //TODO: Add data
                          style: TextStyle(
                              fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
