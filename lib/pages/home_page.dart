import 'package:flutter/material.dart';
import 'package:flutter_testing/widgets/widgets_home/card_home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child:CardHome()
        //
        // Column(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: [
        //     Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: [
        //         Row(
        //           spacing: 32,
        //           children: [
        //             Icon(
        //                 Icons.movie,
        //                 size: 32,
        //             ),
        //             Text(
        //                 "Projects",
        //                 style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        //             ),
        //           ],
        //         ),
        //         IconButton(
        //             onPressed: () {},
        //             icon: Icon(
        //                 Icons.add_circle_outline,
        //                 size: 32
        //             )
        //         ),
        //       ],
        //     ),
        //     Divider(color: Colors.black),
        //     Expanded(
        //       child: GridView.builder(
        //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 4,
        //           childAspectRatio: 1.0,
        //         ),
        //         itemCount: 20, // Example item count, replace with your data
        //         //Test Data
        //         itemBuilder: (context, index) {
        //           return Card(
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: ClipRRect(
        //                     borderRadius: BorderRadius.circular(8),
        //                     child: Image.network(
        //                       "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ3jL6gUvfFslb4OCAOMuiKL7lnxRIByo-e5I_ub2RSdqmkMVCX1rOa6YcfFUXRcxTvOSY&usqp=CAU",
        //                       fit: BoxFit.cover,
        //                     ),
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 8),
        //                   child: Row(
        //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                     children: [
        //                       SizedBox(
        //                         width: MediaQuery.sizeOf(context).width * 0.15,
        //                         child: Text(
        //                           "Create Project dasdkjah dkhk ahdkajhd",
        //                           maxLines: 1,
        //                           overflow: TextOverflow.ellipsis,
        //                         ),
        //                       ),
        //                       IconButton(
        //                           onPressed: () {},
        //                           icon: Icon(Icons.more_vert, color: Colors.black, size: 16)
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           );
        //         },
        //       ),
        //     )
        //   ],
        // ),
      ),
    );
  }
}
