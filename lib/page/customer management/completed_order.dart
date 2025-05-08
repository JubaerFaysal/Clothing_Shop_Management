import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../Components/my_container.dart';
import '../../components/my_dialog_box.dart';

class CompletedOrder extends StatelessWidget {
  final int id;
  const CompletedOrder({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    //final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.cyan,
          title: Text(
            "Completed Orders",
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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Orders')
              .where('Status', isEqualTo: 'Completed')
              .where('Token', isEqualTo: id.toString())
              .orderBy('Delivery_Date')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: MyDialogBox());
            }
            if (snapshot.hasError) {
              // print('Firestore error: ${snapshot.error}');
              return const Center(child: Text('Error loading data'));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No orders found..'));
            }

            final orderedItems = snapshot.data!.docs;

            if (orderedItems.isEmpty) {
              return const Center(child: Text('No Pending Order.'));
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
                    deliveried: () {
                      
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
                    deliveried: () {
                      
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
                    deliveried: () {
                      
                    },
                  ),
            ]);
          }),
    );
  }
}
