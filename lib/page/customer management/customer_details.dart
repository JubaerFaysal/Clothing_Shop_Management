import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_shop/Products/pant.dart';
import 'package:tailor_shop/Products/shirt.dart';
import 'package:tailor_shop/Products/tshirt.dart';
import 'package:tailor_shop/page/customer%20management/completed_order.dart';
import 'package:tailor_shop/page/customer%20management/delivered_order.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../components/my_list_tile.dart';
import 'pending_order.dart';


class CustomerDetails extends StatelessWidget {
  final DocumentSnapshot eachCustomer;
  const CustomerDetails({super.key, required this.eachCustomer});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.cyan,
          title: Text(
            "Customer Details",
            style: GoogleFonts.poppins(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ))),
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth < 600 ? 8 : 24,
            vertical: 8,
          ),
          child: Card(
            elevation: 7,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            surfaceTintColor: Colors.white,
            shadowColor: const Color.fromARGB(255, 8, 72, 124),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person, color: Colors.blue),
                  title: Text(
                    eachCustomer['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(eachCustomer['email']),
                ),
                ListTile(
                  leading: const Icon(Icons.wechat, color: Colors.blue),
                  title: Text(eachCustomer['phone']),
                  trailing: const Icon(Icons.touch_app, color: Colors.blue),
                  onTap: () async {
                    FocusScope.of(context).unfocus();
                    String phone = eachCustomer['phone'];
                    String url =
                        "https://wa.me/$phone?text=Hello Sir,Your Order is Completed. Come and receive your product";
                    final Uri uri = Uri.parse(url);
      
                    if (Platform.isIOS || Platform.isAndroid) {
                      if (!await launchUrl(uri,
                          mode: LaunchMode.externalApplication)) {
                        throw 'Could not launch $url';
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                "This feature is only supported on real devices.")),
                      );
                    }
                  },
                ),
                ListTile(
                  leading:
                      const Icon(Icons.calendar_today, color: Colors.blue),
                  title: Text("Date of Birth: ${eachCustomer['DoB']}"),
                ),
              ],
            ),
          ),
        ),
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyListTile(
            icon: Icons.holiday_village,
            title: "Pending Orders",
            tilecolor: Colors.blueAccent,
            iconcolor: Colors.deepOrange,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PendingOrder(
                        id: eachCustomer['id'],
                      )),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyListTile(
            icon: Icons.done_all,
            title: "Completed Orders",
            tilecolor: const Color.fromARGB(255, 25, 175, 255),
            iconcolor: Colors.purple,
            onTap: () { 
              Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CompletedOrder(
                        id: eachCustomer['id'],
                      )),
            );
            }
          ),
        ),
         Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyListTile(
            icon: Icons.delivery_dining,
            title: "Delivered Orders",
            tilecolor: Colors.cyanAccent,
            iconcolor: Colors.black,
            onTap: () {
              Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DeliveredOrder(
                        eachCustomer: eachCustomer,
                      )),
            );
            }
          ),
        ),
      ]),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: const Color.fromARGB(255, 0, 226, 226),
        elevation: 9,
        buttonSize: const Size(60, 60),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        children: [
          SpeedDialChild(
            label: "Shirt",
            labelBackgroundColor: Colors.cyanAccent,
            backgroundColor: Colors.cyanAccent,
            child: const Icon(Icons.checkroom),
            onTap: () => shirt(context, eachCustomer.id, "Shirt"),
          ),
          SpeedDialChild(
            label: "Pants",
            labelBackgroundColor: Colors.cyanAccent,
            backgroundColor: Colors.cyanAccent,
            child: const Icon(Icons.style),
            onTap: () {
              pant(context, eachCustomer.id, "Pant");
            }
          ),
          SpeedDialChild(
            label: "T-Shirt",
            labelBackgroundColor: Colors.cyanAccent,
            backgroundColor: Colors.cyanAccent,
            child: const Icon(Icons.shopping_cart),
            onTap: () {
              tshirt(context, eachCustomer.id, "T-Shirt");
            }
          ),
          SpeedDialChild(
            label: "Formal",
            labelBackgroundColor: Colors.cyanAccent,
            backgroundColor: Colors.cyanAccent,
            child: const Icon(Icons.checkroom_outlined),
            onTap: () {}
          ),
          SpeedDialChild(
            label: "Borkha",
            labelBackgroundColor: Colors.cyanAccent,
            backgroundColor: Colors.cyanAccent,
            child: const Icon(Icons.hiking),
            onTap: (){}
          ),
         
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
