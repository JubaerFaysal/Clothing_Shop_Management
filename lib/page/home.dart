import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tailor_shop/Components/my_button.dart';
import 'package:tailor_shop/Methods/inventory_method.dart';
import 'package:tailor_shop/Methods/timer.dart';
import 'package:tailor_shop/page/details_order.dart';
import 'package:tailor_shop/page/inventory/inventory_view.dart';
import '../Components/my_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 230, 230, 230),
        appBar: AppBar(
         elevation: 5,
          backgroundColor: Colors.teal.shade500,
          title: Text(
            "Home",
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  WebCategoryMethod.addInventory(context);
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: Text("Add Category",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                ),
              ),
            ),
          ],
        ),
        drawer: const MyDrawer(),
        body: ListView(padding: const EdgeInsets.all(16), children: [
          inventoryView(),
          const SizedBox(height: 20),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Orders')
                  .where('Status', isEqualTo: 'Pending')
                  .orderBy('Delivery_Date', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.cyan));
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading data'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No orders found.'));
                }

                final orderedItems = snapshot.data!.docs;

                return Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 16),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF4DD0E1), Color(0xFF00796B)],
                              
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Pending Orders",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final itemWidth = (constraints.maxWidth - 12) / 2;

                            return Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: orderedItems.map((eachItem) {
                                return SizedBox(
                                  width: itemWidth,
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF5F5F5),
                                      borderRadius: BorderRadius.circular(15),
                                      border: Border.all(
                                          color: Colors.teal, width: 1),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 5,
                                          offset: Offset(2, 3),
                                        )
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              eachItem['Measurement'],
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.teal,
                                                 decoration:
                                                    TextDecoration.underline,
                                                decorationStyle: TextDecorationStyle.solid, 
                                                decorationColor: Colors.teal,
                                                   letterSpacing: 1.2,
                                                decorationThickness: 2,
                                              ),
                                            ),
                                              MyButton(
                                              text: "View Details",
                                              color: Colors.teal,
                                              icon: Icons.visibility,
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        DetailsOrder(
                                                            eachItem: eachItem),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 6),
                                        Text("Token: ${eachItem['Token']}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500)),
                                        Text("Fabric: ${eachItem['Fabric']}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14)),
                                        Text(
                                            "Quantity: ${eachItem['Quantity']}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14)),
                                        Text(
                                            "Unit_Price: ${eachItem['Unit_Price']}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14)),
                                        Text(
                                            "Total_Price: ${eachItem['Total_Price']}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14)),
                                        Text("Advance: ${eachItem['Advance']}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14)),
                                        Text("Due: ${eachItem['Due']}",
                                            style: GoogleFonts.poppins(
                                                fontSize: 14)),
                                        Text(
                                          "Delivery: ${DateFormat('yyyy-MM-dd').format(eachItem['Delivery_Date'].toDate())}",
                                          style:
                                              GoogleFonts.poppins(fontSize: 13),
                                        ),
                                        const SizedBox(height: 10,),
                                        DeadlineTimer(orderId: eachItem.id),
                                       
                                       
                                       
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        )
                      ],
                    ));
              })
        ]));
  }
}
