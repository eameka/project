import "package:cloud_firestore/cloud_firestore.dart";
import "package:ecowaste/screens/household/auth/auth_service.dart";
import "package:ecowaste/screens/household/house/cleanupmade.dart";
import "package:ecowaste/screens/household/house/pickupmade.dart";
import "package:ecowaste/screens/household/profile/houselogin.dart";
import "package:ecowaste/widgets.dart/drawer_widget.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";

class House extends StatefulWidget {
  const House({super.key});

  @override
  State<House> createState() => _HouseState();
}

class _HouseState extends State<House> {
  final _auth = AuthService();

  CollectionReference companies =
      FirebaseFirestore.instance.collection('waste_company');

  int pickupRequestsCount = 0;
  int cleanupRequestsCount = 0;
  bool isLoadingRequests = true;

  @override
  void initState() {
    super.initState();
    _fetchRequestsCount();
  }

  Future<void> _fetchRequestsCount() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final pickupSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('pickup_orders')
            .get();
        final cleanupSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('cleanup_orders')
            .get();

        setState(() {
          pickupRequestsCount = pickupSnapshot.docs.length;
          cleanupRequestsCount = cleanupSnapshot.docs.length;
          isLoadingRequests = false;
        });
      }
    } catch (e) {
      print("Error fetching requests count: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      drawer: const drawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => Pickupmade(
                            currentUser: FirebaseAuth.instance.currentUser!,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 1,
                      color: Colors.white,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        height: 180,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.maxFinite,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color.fromARGB(
                                            37, 142, 250, 155)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        isLoadingRequests
                                            ? CupertinoActivityIndicator()
                                            : Text(
                                                "$pickupRequestsCount",
                                                style: TextStyle(
                                                    fontSize: 60,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Pickup Requests',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                 
                  ),
                  
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => CleanupOrdersList(
                              FirebaseAuth.instance.currentUser),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 1,
                      color: Colors.white,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.40,
                        height: 180,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.maxFinite,
                                    height: 120,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color.fromARGB(
                                            37, 142, 250, 155)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        isLoadingRequests
                                            ? CupertinoActivityIndicator()
                                            : Text(
                                                "$cleanupRequestsCount",
                                                style: TextStyle(
                                                    fontSize: 60,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    'Cleanup Requests',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Available Waste Companies',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.45,
                child: StreamBuilder(
                    stream: companies.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'An error ocurred while fetching data',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: CupertinoActivityIndicator(
                                color: Color.fromARGB(255, 103, 196, 107),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Center(
                              child: Text(
                                'Loading companies...',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 103, 196, 107),
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ],
                        );
                      }

                      return ListView.separated(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ExpansionTile(
                              title: Text(
                                  snapshot.data!.docs[index]["company_name"]),
                              collapsedIconColor: Colors.white,
                              collapsedTextColor: Colors.white,
                              collapsedBackgroundColor: Colors.green,
                              collapsedShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(color: Colors.black),
                              ),
                              children: <Widget>[
                                ListTile(
                                  title: const Text("Location"),
                                  subtitle: Text(
                                    snapshot.data!.docs[index]["location"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ListTile(
                                  title: const Text(
                                    "Available Days",
                                  ),
                                  subtitle: Text(
                                    snapshot.data!.docs[index]
                                        ["available_days"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, builder) {
                          return const Divider(
                            height: 0,
                            color: Color.fromARGB(255, 235, 234, 234),
                          );
                        },
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
