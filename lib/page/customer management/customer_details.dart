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
        backgroundColor: Colors.teal.shade500,
        title: Text(
          "Customer Details",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth < 600 ? 12 : 24,
          vertical: 16,
        ),
        children: [
          _buildCustomerCard(context),
          const SizedBox(height: 12),
          _buildSectionTitle("Orders"),
          const SizedBox(height: 6),
          _buildOrderTile(
            context,
            icon: Icons.holiday_village,
            title: "Pending Orders",
            color: Colors.blueAccent,
            iconColor: Colors.deepOrange,
            route: PendingOrder(id: eachCustomer['id']),
          ),
          _buildOrderTile(
            context,
            icon: Icons.done_all,
            title: "Completed Orders",
            color: Colors.indigo,
            iconColor: Colors.amber,
            route: CompletedOrder(id: eachCustomer['id']),
          ),
          _buildOrderTile(
            context,
            icon: Icons.delivery_dining,
            title: "Delivered Orders",
            color: Colors.teal,
            iconColor: Colors.black,
            route: DeliveredOrder(eachCustomer: eachCustomer),
          ),
        ],
      ),
      floatingActionButton: _buildSpeedDial(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildCustomerCard(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.teal.shade300,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.person, color: Colors.teal),
              title: Text(
                eachCustomer['name'],
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600,fontSize: 17),
              ),
              subtitle: Text(eachCustomer['email']),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.teal),
              title: Text(eachCustomer['phone']),
              trailing: const Icon(Icons.message, color: Colors.teal),
              onTap: () async {
                String phone = eachCustomer['phone'];
                String url =
                    "https://wa.me/$phone?text=Hello Sir, your order is completed. Please collect it.";
                final Uri uri = Uri.parse(url);

                if (Platform.isIOS || Platform.isAndroid) {
                  if (!await launchUrl(uri,
                      mode: LaunchMode.externalApplication)) {
                    throw 'Could not launch $url';
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("This feature works on real devices only."),
                    ),
                  );
                }
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.cake, color: Colors.teal),
              title: Text("Date of Birth: ${eachCustomer['DoB']}"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, bottom: 4),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade800,
        ),
      ),
    );
  }

  Widget _buildOrderTile(BuildContext context,
      {required IconData icon,
      required String title,
      required Color color,
      required Color iconColor,
      required Widget route}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: MyListTile(
        icon: icon,
        title: title,
        tilecolor: color,
        iconcolor: iconColor,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => route),
        ),
      ),
    );
  }

  Widget _buildSpeedDial(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      backgroundColor: Colors.teal,
      elevation: 9,
      buttonSize: const Size(60, 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      children: [
        _buildSpeedDialChild("Shirt", Icons.checkroom, () {
          shirt(context, eachCustomer.id, "Shirt");
        }),
        _buildSpeedDialChild("Pants", Icons.style, () {
          pant(context, eachCustomer.id, "Pant");
        }),
        _buildSpeedDialChild("T-Shirt", Icons.shopping_cart, () {
          tshirt(context, eachCustomer.id, "T-Shirt");
        }),
        _buildSpeedDialChild("Formal", Icons.checkroom_outlined, () {}),
        _buildSpeedDialChild("Borkha", Icons.hiking, () {}),
      ],
    );
  }

  SpeedDialChild _buildSpeedDialChild(
      String label, IconData icon, VoidCallback onTap) {
    return SpeedDialChild(
      label: label,
      labelBackgroundColor: Colors.teal.shade50,
      backgroundColor: Colors.teal.shade100,
      child: Icon(icon, color: Colors.teal.shade900),
      onTap: onTap,
    );
  }
}
