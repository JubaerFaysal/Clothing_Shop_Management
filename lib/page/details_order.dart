// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tailor_shop/Components/my_appbar.dart';
import 'package:tailor_shop/components/completed_aleart.dart';
import 'package:tailor_shop/components/my_dialog_box.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Components/my_container.dart';

class DetailsOrder extends StatelessWidget {
  final DocumentSnapshot eachItem;
  const DetailsOrder({super.key, required this.eachItem});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const MyAppbar(name: "Order Details"),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Customers')
            .doc(eachItem['Token'])
            .snapshots(), // Listening for real-time updates
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: MyDialogBox());
          }

          if (snapshot.hasError ||
              !snapshot.hasData ||
              !snapshot.data!.exists) {
            return const Center(child: Text("Error fetching customer details"));
          }

          var customerData = snapshot.data!.data() as Map<String, dynamic>;

          return ListView(
            children: [
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
                          customerData['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(customerData['email']),
                      ),
                      ListTile(
                        leading: const Icon(Icons.wechat, color: Colors.blue),
                        title: Text(customerData['phone']),
                        trailing:
                            const Icon(Icons.touch_app, color: Colors.blue),
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          String phone = customerData['phone'];
                          String url =
                              "https://wa.me/$phone?text=Hello Sir,Your Order is Completed. Come and receive your product";
                          final Uri uri = Uri.parse(url);

                          if (!kIsWeb &&
                              (Platform.isIOS || Platform.isAndroid)) {
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
                        leading: const Icon(Icons.calendar_today,
                            color: Colors.blue),
                        title: Text("Date of Birth: ${customerData['DoB']}"),
                      ),
                    ],
                  ),
                ),
              ),
              if (eachItem["Measurement"] == "Shirt")
                MyContainer(
                  id: eachItem.id,
                  measurement: eachItem['Measurement'],
                  token: eachItem['Token'],
                  quantity: eachItem['Quantity'],
                  unitPrice: eachItem['Unit_Price'],
                  totalPrice: eachItem['Total_Price'],
                  advance: eachItem['Advance'],
                  due: eachItem['Due'],
                  orderDate: eachItem['Order_Date'],
                  deliveryDate: DateFormat('yyyy-MM-dd')
                      .format(eachItem['Delivery_Date'].toDate()),
                  Neck_Circumference: eachItem['Neck Circumference'],
                  Shoulder_Width: eachItem['Shoulder Width'],
                  Chest_Bust: eachItem['ChestorBust'],
                  waist: eachItem['waist'],
                  Sleeve_Length: eachItem['Sleeve Length'],
                  Arm_Hole: eachItem['Arm Hole'],
                  bicep: eachItem['bicep'],
                  Cuff_Circumference: eachItem['Cuff Circumference'],
                  Shirt_Length: eachItem['Shirt Length'],
                  completed: () async {
                    completedAleart(eachItem, context);
                  },
                ),
              if (eachItem["Measurement"] == "Pant")
                MyContainer(
                  id: eachItem.id,
                  measurement: eachItem['Measurement'],
                  token: eachItem['Token'],
                  quantity: eachItem['Quantity'],
                  unitPrice: eachItem['Unit_Price'],
                  totalPrice: eachItem['Total_Price'],
                  advance: eachItem['Advance'],
                  due: eachItem['Due'],
                  orderDate: eachItem['Order_Date'],
                  deliveryDate: DateFormat('yyyy-MM-dd')
                      .format(eachItem['Delivery_Date'].toDate()),
                  waist: eachItem['waist'],
                  Hip: eachItem['Hip'],
                  Front_Rise: eachItem['Front_Rise'],
                  Crotch_Depth: eachItem['Crotch_Depth'],
                  Back_Rise: eachItem['Back_Rise'],
                  Inseam: eachItem['Inseam'],
                  Outseam: eachItem['Outseam'],
                  Thigh: eachItem['Thigh'],
                  Knee: eachItem['Knee'],
                  Leg_Opening: eachItem['Leg_Opening'],
                  completed: () async {
                    completedAleart(eachItem, context);
                  },
                ),
              if (eachItem["Measurement"] == "T-Shirt")
                MyContainer(
                  id: eachItem.id,
                  measurement: eachItem['Measurement'],
                  token: eachItem['Token'],
                  quantity: eachItem['Quantity'],
                  unitPrice: eachItem['Unit_Price'],
                  totalPrice: eachItem['Total_Price'],
                  advance: eachItem['Advance'],
                  due: eachItem['Due'],
                  orderDate: eachItem['Order_Date'],
                  deliveryDate: DateFormat('yyyy-MM-dd')
                      .format(eachItem['Delivery_Date'].toDate()),
                  hem: eachItem['Hem'],
                  Shoulder_Width: eachItem['Shoulder Width'],
                  Chest_Bust: eachItem['ChestorBust'],
                  Sleeve_Length: eachItem['Sleeve Length'],
                  Arm_Hole: eachItem['Arm Hole'],
                  bicep: eachItem['bicep'],
                  neckOpening: eachItem['neckOpening'],
                  Shirt_Length: eachItem['Shirt Length'],
                  completed: () async {
                    completedAleart(eachItem, context);
                  },
                ),
            ],
          );
        },
      ),
    );
  }
}
