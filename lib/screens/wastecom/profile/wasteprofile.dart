import 'package:flutter/material.dart';

class Wasteprofile extends StatefulWidget {
  const Wasteprofile({super.key});

  @override
  State<Wasteprofile> createState() => _WasteprofileState();
}

class _WasteprofileState extends State<Wasteprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waste company name',
            style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const CircleAvatar(
          radius: 10,
          backgroundImage: AssetImage(""),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          AnimatedCrossFade(
            firstChild: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Image.asset(
                "assets/waste.png",
                fit: BoxFit.fill,
              ),
            ),
            secondChild: Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Image.asset(
                "assets/waste.png",
                fit: BoxFit.fill,
              ),
            ),
            crossFadeState: CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 3000),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Text('Contact'),
                  subtitle: const Text('Contact us for any queries'),
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Text('E-mail'),
                  subtitle: const Text('wastecompany@gmail.com'),
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Text('Wallet'),
                  subtitle: const Text('Add money to your wallet'),
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Container(
                  width: double.infinity, 
                  height: 1, 
                  color: Colors.grey, 
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: const Text('Log out'),
                  onTap: () {
                    
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
