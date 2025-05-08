
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_shop/page/customer%20management/customers.dart';
import 'package:tailor_shop/page/drawe%20page/completed.dart';
import 'package:tailor_shop/page/drawe%20page/delivered.dart';

import 'my_button.dart';
import 'my_list_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    // final screenWidth = MediaQuery.of(context).size.width;
    // final screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Drawer Header with Branding & Avatar
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal, Color.fromARGB(255, 212, 235, 254)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            accountName: Text(
              "Tailor Shop",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            accountEmail: Text(
              "tailorshop@gmail.com",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            currentAccountPicture: const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage("lib/images/pphoto.jpg"),
            )
           
          ),

          // Custom ListTiles
          Expanded(
            child: ListView(
              children: [
                MyListTile(
                  icon: Icons.home,
                  title: "H O M E",
                  onTap: () => Navigator.pop(context),
                ),
                const SizedBox(height: 10),
                MyListTile(
                  icon: Icons.people,
                  title: "C U S T O M E R S",
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Customers()),
                  ),
                ),
                const SizedBox(height: 10),
                MyListTile(
                  icon: Icons.done,
                  title: "COMPLETED",
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const Completed()));
                  }
                 
                ),
                const SizedBox(height: 10),
                MyListTile(
                  icon: Icons.delivery_dining,
                  iconcolor: const Color.fromARGB(255, 0, 0, 0),
                  title: "D E L I V E R E D",
                  onTap: (){
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Delivered()));
                  }
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),

          // Footer Logout Button
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: MyButton(
              text: "LogOut",
              color: Colors.red,
              icon: Icons.logout,
              textcolor: Colors.white,
              onPressed: () {
                Navigator.pop(context);
                FirebaseAuth.instance.signOut();
              },
              height: 50,
              width: 170,
              fontsize: 16,
             
            ),
          )
        ],
      ),
    );
  }
}
