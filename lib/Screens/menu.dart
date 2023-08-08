// import 'package:flutter/material.dart';
import 'package:my_flutter_app_dl/Screens/dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page.dart';

// class Dashboard extends StatelessWidget {
//   const Dashboard({super.key});

//   void initState() {
//     contents();
//   }

//   void contents() {}

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard'),
//       ),
//       body: Container(
//         alignment: Alignment.center,
//         child: Column(
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () async {
//                 SharedPreferences sharedPreferences =
//                     await SharedPreferences.getInstance();
//                 sharedPreferences.clear();
//                 Navigator.of(context).pushAndRemoveUntil(
//                     MaterialPageRoute(
//                         builder: (BuildContext context) => const HomePage()),
//                     (Route<dynamic> route) => false);
//                 //sharedPreferences.commit();
//               },
//               child:
//                   const Text("Log Out", style: TextStyle(color: Colors.blue)),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              //Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Dashboard()),
                  (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Logout'),
            onTap: () async {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              sharedPreferences.clear();
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const HomePage()),
                  (Route<dynamic> route) => false);
              //sharedPreferences.commit();
            },
          ),
        ],
      ),
    );
  }
}
