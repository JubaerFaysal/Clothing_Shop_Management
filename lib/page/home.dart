import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:tailor_shop/Methods/inventory_method.dart';
import 'package:tailor_shop/page/details_order.dart';
import 'package:tailor_shop/page/inventory/inventory_view.dart';
import '../Components/my_container.dart';
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
        backgroundColor:  const Color.fromARGB(255, 225, 223, 223),
        appBar: AppBar(
          elevation: 5,
          backgroundColor: const Color.fromARGB(255, 8, 172, 155),
          title: Text("Home",
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                  color: Colors.white)),
          actions: [
            TextButton.icon(
              onPressed: () {
                WebCategoryMethod.addInventory(context);
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                    const Color.fromARGB(255, 24, 205, 255)),
              ),
              label: Text("Add Category",
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white)),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          ],
          leading: Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 27),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ),
        drawer: const MyDrawer(),
        body: ListView(children: [
          mycolumn(),
          const SizedBox(
            height: 15,
          ),
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Orders')
                  .where('Status', isEqualTo: 'Pending')
                  .orderBy('Delivery_Date', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: Text('Waiting for connection..'));
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Error loading data'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No orders found..'));
                }

                final orderedItems = snapshot.data!.docs;

                if (orderedItems.isEmpty) {
                  return const Center(child: Text('No orders found.'));
                }
                return Container(
                    width: double.infinity,
                    // height: 200,
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                    margin: const EdgeInsets.only(top: 10),
                    decoration: const BoxDecoration(
                      
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25)),
                        border: Border(
                          top: BorderSide(
                            color: Colors.cyan,
                            width: 2.5,
                          ),
                        ),
                        color: Color.fromARGB(255, 255, 255, 255)
                       ),
                    child: Column(children: [
                      Container(
                        margin: const EdgeInsets.all(4),
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 15),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color.fromARGB(255, 154, 154, 240),
                              Colors.teal
                            ]),
                            borderRadius: BorderRadius.circular(20)),
                        child: Text("Pending Orders-",
                            style: GoogleFonts.poppins(
                                fontSize: 24,
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      for (var eachItem in orderedItems)
                        MyContainer(
                            id: eachItem.id,
                            measurement: eachItem['Measurement'],
                            token: eachItem['Token'],
                            fabric: eachItem['Fabric'],
                            quantity: eachItem['Quantity'],
                            unitPrice: eachItem['Unit_Price'],
                            totalPrice: eachItem['Total_Price'],
                            advance: eachItem.data().containsKey('Advance')
                                ? eachItem['Advance']
                                : null,
                            due: eachItem.data().containsKey('Due')
                                ? eachItem['Due']
                                : null,
                            productName:
                                eachItem.data().containsKey('Product_Name')
                                    ? eachItem['Product_Name']
                                    : null,
                            deliveryDate: DateFormat('yyyy-MM-dd')
                                .format(eachItem['Delivery_Date'].toDate()),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsOrder(eachItem: eachItem),
                                ),
                              );
                            }),
                    ]));
              })
        ]));
  }
}
