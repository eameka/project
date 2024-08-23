import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../register.dart';
import '../screens/household/auth/auth_service.dart';

class CompanyDrawer extends StatefulWidget {
  const CompanyDrawer({super.key});

  @override
  State<CompanyDrawer> createState() => _CompanyDrawerState();
}

class _CompanyDrawerState extends State<CompanyDrawer> {
  String name = '';
  String contact = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _getUserDetails();
  }

  _getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString("company_name")!;
      contact = prefs.getString("company_contact")!;
      email = prefs.getString("company_email")!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 108, 119, 108),
            ),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Center(
                      child: Icon(
                    CupertinoIcons.person,
                    size: 30,
                  )),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  name,
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Mobile Number'),
            subtitle: Text(contact),
            leading: const Icon(Icons.phone),
            onTap: () {
              // Call API or perform action here
            },
          ),
          ListTile(
            title: const Text('E-mail'),
            subtitle: Text(email),
            leading: const Icon(Icons.mail),
            onTap: () {
              // Call API or perform action here
            },
          ),
         
          ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.logout),
              onTap: () async {
                showDialog(
                  context: context,
                  builder: (builder) {
                    return CupertinoAlertDialog(
                      title: const Text("Alert"),
                      content: const Text("Do you really want to signout?"),
                      actions: [
                        CupertinoDialogAction(
                          child: const Text("No"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoDialogAction(
                          isDestructiveAction: true,
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            prefs.remove('company_name');
                            prefs.remove('company_email');
                            prefs.remove('company_contact');

                            await FirebaseAuth.instance.signOut().then((value) {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (context) => const MyAccount(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            });
                          },
                          child: const Text("Yes"),
                        )
                      ],
                    );
                  },
                );

                // _showDialog(BuildContext context) {
                //   CupertinoAlertDialog alert = CupertinoAlertDialog(
                //     title: Text('Message'),
                //     content: Text('Do you really want to logout?'),
                //     actions: <Widget>[
                //       CupertinoDialogAction(
                //         child: Text('No'),
                //         onPressed: () {
                //           Navigator.pop(context);
                //         },
                //       ),
                //       CupertinoDialogAction(
                //         isDestructiveAction: true,
                //         child: Text('Yes'),
                //         onPressed: () async {
                //           await FirebaseAuth.instance.signOut();
                //           SharedPreferences prefs =
                //               await SharedPreferences.getInstance();

                //           prefs.remove('adminName');
                //           prefs.remove('adminEmail');
                //           await FirebaseAuth.instance.signOut().then((value) {
                //             Navigator.of(context).pushAndRemoveUntil(
                //               MaterialPageRoute(
                //                 builder: (context) => MyHouseLogin(),
                //               ),
                //               (Route<dynamic> route) => false,
                //             );
                //           });
                //         },
                //       ),
                //     ],
                //   );

                //   // await _auth.signout();
                // }
              }),
        ],
      ),
    );
  }
}
