// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tailor_shop/components/delivery_aleart.dart';
import 'package:tailor_shop/components/my_container.dart';
import '../../Components/my_dialog_box.dart';

class Completed extends StatefulWidget {
  const Completed({super.key});

  @override
  State<Completed> createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController dueController = TextEditingController();
  String searchQuery = '';
  bool isSearchVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
       elevation: 5,
        backgroundColor: Colors.teal.shade500,
        title: isSearchVisible
            ? SizedBox(
                width: 200,
                child: TextField(
                  controller: _searchController,
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    hintText: "Search by Token..",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                  style: const TextStyle(color: Colors.white),
                  autofocus: true, // Automatically focuses when opened
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                ),
              )
            : const Text(
                "Completed Orders",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  letterSpacing: 1.2,
                ),
              ),
        actions: [
          IconButton(
            icon: Icon(isSearchVisible ? Icons.close : Icons.search,
                color: Colors.white),
            onPressed: () {
              setState(() {
                if (isSearchVisible) {
                  _searchController.clear();
                  searchQuery = '';
                }
                isSearchVisible = !isSearchVisible;
              });
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Orders')
              .where('Status', isEqualTo: 'Completed')
              .orderBy('Delivery_Date')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: MyDialogBox());
            }
            if (snapshot.hasError) {
              return const Center(child: Text('Error loading data'));
            }
      
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No orders found.'));
            }
      
            final completedItem = snapshot.data!.docs;
      
            // Filter items by token number
            final filteredItems = completedItem.where((item) {
              String token = item['Token'].toString();
              return searchQuery.isEmpty || token.contains(searchQuery);
            }).toList();
      
            if (filteredItems.isEmpty) {
              return const Center(child: Text('No Order is Completed yet.'));
            }
      
            return ListView(children: [
              for (var eachItem in filteredItems)
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
                    deliveryAlert(eachItem, context, dueController);
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
                  deliveryAlert(eachItem, context, dueController);
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
                  deliveryAlert(eachItem, context, dueController);
                 },
                )
               
            ]);
          }),
    );
  }
}
