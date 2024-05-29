import 'houselogin.dart';
import 'registerhouse.dart';
import 'registerwaste.dart';
import 'wastelogin.dart';
import 'package:flutter/material.dart';



class MyAccount extends StatefulWidget {
  const MyAccount({
    super.key,
  });

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height:10,),
        Image.asset('assets/s.png'),
        const SizedBox(height:100,),
        const Text(
          "Let's Clean Together",
         style: TextStyle(fontSize: 30,color: Colors.black, decoration: TextDecoration.none),
        ),
        const SizedBox(height:10,),
        const Text(
          "Join us and let's promote a healthy environment.",
          style: TextStyle(fontSize: 15,color: Colors.black,decoration: TextDecoration.none),
        ),
        const SizedBox(height:20,),
        ElevatedButton(
          onPressed: ()  => Navigator.push(context,MaterialPageRoute(builder: (context) => const MyHouseSignup(),)),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 1, 216, 8))),
          child: const Text(
            "Register Household account",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height:10,),
        ElevatedButton(
          onPressed: ()  => Navigator.push(context,MaterialPageRoute(builder: (context) => const MyWasteSignup(),)),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 1, 212, 8))),
          child: const Text(
            "Register Waste Company account",
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height:10,),
        ElevatedButton(
          onPressed: () {
           showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 200,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Text('LOGIN'),
                      const SizedBox(height:20,),
                      ElevatedButton(
                        child: const Text('Login as Household'),
                        onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => const MyHouseLogin(),)),
                      ),
                      const SizedBox(height:10,),
                       ElevatedButton(
                        child: const Text('Login as Waste company'),
                        onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) =>const MywasteLogin(), )),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
          },
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 1, 219, 8))),
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
