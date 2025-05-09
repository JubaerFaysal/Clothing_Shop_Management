import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tailor_shop/Products/pant.dart';
import 'package:tailor_shop/Products/shirt.dart';
import 'package:tailor_shop/Products/tshirt.dart';
import 'package:tailor_shop/components/my_container.dart';
import 'package:tailor_shop/components/my_dialog_box.dart';

import '../components/my_button.dart';

class NewOrder extends StatelessWidget {
  final String id;
  const NewOrder({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
           elevation: 5,
          backgroundColor: Colors.teal.shade500,
          title: Text(
            "New Order",
            style: GoogleFonts.poppins(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ))
          ],
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
              .where('Status', isEqualTo: 'Pending')
              .where('Token', isEqualTo: id)
              .orderBy('Delivery_Date')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: MyDialogBox());
            }
      
            final orderedItems = snapshot.data!.docs;
      
            if (orderedItems.isEmpty) {
              return const Center(child: Text('No New Order.'));
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
                    modify: () {},
                    newItem: () {},
                    delete: () {},
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
                    modify: () {},
                    newItem: () {},
                    delete: () {},
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
                    modify: () {},
                    newItem: () {},
                    delete: () {},
                  ),
            ]);
          }),
      floatingActionButton: MyButton(
        text: "Select Item",
        height: 50,
        width: 200,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            
            builder: (BuildContext context) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    MyButton(
                      onPressed: () {
                        shirt(context, id, "Shirt");
                      },
                      text: "- Shirt",
                      // width: ,
                      height: 55,
                       fontsize: 18,
                      textcolor: Colors.white,
                      color: Colors.blue,
                      icon: Icons.shopify,
                    ),
                    const SizedBox(height: 12),
                    MyButton(
                      onPressed: () {
                        pant(context, id, "Pant");
                      },
                      text: "- Pants",
                      height: 55,
                       fontsize: 18,
                      textcolor: Colors.white,
                      color: Colors.blue,
                      icon: Icons.shopping_cart,
                    ),
                    const SizedBox(height: 12),
                    MyButton(
                      onPressed: () {
                        tshirt(context, id, "T-Shirt");
                      },
                      text: "- T-Shirt",
                      height: 55,
                       fontsize: 18,
                      textcolor: Colors.white,
                      color: Colors.blue,
                      icon: Icons.shopify,
                    ),
                    const SizedBox(height: 12),
                    MyButton(
                      onPressed: () {},
                      text: "- Formal",
                      height: 55,
                       fontsize: 18,
                      textcolor: Colors.white,
                      color: Colors.blue,
                      icon: Icons.shopping_basket_outlined,
                    ),
                    const SizedBox(height: 12),
                    MyButton(
                      onPressed: () {},
                      text: "- Borkha",
                      height: 55,
                       fontsize: 18,
                      textcolor: Colors.white,
                      color: Colors.blue,
                      icon: Icons.local_mall,
                    ),
                    const SizedBox(height: 12),
                    MyButton(
                      onPressed: () {},
                      text: "- Dress",
                      height: 55,
                       fontsize: 18,
                      textcolor: Colors.white,
                      color: Colors.blue,
                      icon: Icons.shopping_basket,
                    ),
                    const SizedBox(height: 12),
                    MyButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: "Done",
                      height: 55,
                      color: Colors.red,
                      icon: Icons.done,
                       fontsize: 18,
                      textcolor: Colors.white,
                    )
                  ],
                ),
              );
            },
          );
        },
        fontsize: 18,
        textcolor: Colors.white,
        //height: 55,
        icon: Icons.add,
        color: Colors.blue,
        //buttonBlur: 0.2,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
