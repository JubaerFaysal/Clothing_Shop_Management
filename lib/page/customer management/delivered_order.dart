import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Components/my_appbar.dart';
import '../../Components/my_container.dart';
import '../../Components/my_dialog_box.dart';


class DeliveredOrder extends StatelessWidget {
  final DocumentSnapshot eachCustomer;
  const DeliveredOrder({super.key, required this.eachCustomer});

  @override
  Widget build(BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const MyAppbar(name: "Delivered Order"),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 129, 221, 255)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Orders')
                .where('Status', isEqualTo: 'Delivered')
                .where('Token', isEqualTo: eachCustomer['id'].toString())
                .orderBy('Delivery_Date')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: MyDialogBox());
              }

              final orderedItems = snapshot.data!.docs;

              if (orderedItems.isEmpty) {
                return const Center(child: Text('No Item is Delivered yet.'));
              }
              return ListView(children: [
                for (var eachItem in orderedItems)
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
                    newItem: () {
                      
                    },
                  )
                else if (eachItem["Measurement"] == "Pant")
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
                   newItem: () {
                     
                   },
                  )
                else if (eachItem["Measurement"] == "T-Shirt")
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
                   newItem: () {
                     
                   },
                  ),
                 
              ]);
            }),
      ),
    );
  }
}
