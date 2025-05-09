import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_shop/components/my_button.dart';
import 'package:tailor_shop/page/customer%20management/customer_details.dart';
import 'package:tailor_shop/page/persons_info.dart';

import '../../Components/my_dialog_box.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  bool isSearchVisible = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.teal.shade500,
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isSearchVisible
              ? SizedBox(
                  key: const ValueKey('search'),
                  width: isWideScreen ? 400 : 200,
                  child: TextField(
                    controller: _searchController,
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      hintText: "Search by Name, Phone or Token...",
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                    style: const TextStyle(color: Colors.white),
                    autofocus: true,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                )
              : const Text(
                  "Customers",
                  key: ValueKey('title'),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 1.2,
                  ),
                ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isSearchVisible ? Icons.close : Icons.search,
              color: Colors.white,
            ),
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
        stream: FirebaseFirestore.instance.collection('Customers').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: MyDialogBox());
          }

          final customers = snapshot.data!.docs;

          final filteredCustomer = customers.where((item) {
            String token = item['id'].toString();
            String name = item['name'].toString();
            String phone = item['phone'].toString();
            return searchQuery.isEmpty ||
                token.contains(searchQuery) ||
                phone.contains(searchQuery) ||
                name.toLowerCase().contains(searchQuery.toLowerCase());
          }).toList();

          if (filteredCustomer.isEmpty) {
            return const Center(child: Text('No customers available.'));
          }

          return ListView.builder(
            itemCount: filteredCustomer.length,
            itemBuilder: (context, index) {
              final eachCustomer = filteredCustomer[index];
              final name = eachCustomer['name'];
              final phone = eachCustomer['phone'];

              return Padding(
                padding: const EdgeInsets.only(left: 12,right: 12),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  
                  shadowColor: Colors.teal,
                  elevation: 7,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(5),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CustomerDetails(eachCustomer: eachCustomer),
                        ),
                      );
                    },
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.teal,
                      child: Text(
                        name[0].toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    title: Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          const Icon(Icons.phone, size: 16, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text(
                            phone,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.teal,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: MyButton(
        text: "New Customer",
        onPressed: () {
          personsInfo(context);
        },
        fontsize: 18,
        icon: Icons.person_add_alt_1,
        color: Colors.teal,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
