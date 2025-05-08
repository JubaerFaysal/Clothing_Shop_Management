// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tailor_shop/components/my_dialog_box.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

// Controller to manage image state
class WebImageController extends GetxController {
  Rx<Uint8List?> imageBytes = Rx<Uint8List?>(null);
  RxString imageName = ''.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final bytes = await file.readAsBytes();
      imageBytes.value = bytes;
      imageName.value = file.name;
    }
  }
}

// Global instances
final webController = Get.put(WebImageController());
final cloudinary = CloudinaryPublic('duoqdpodl', 'Mudi_upload', cache: false);
final _firestore = FirebaseFirestore.instance;

class WebCategoryMethod {
  static Future<void> addInventory(BuildContext context) async {
    final nameController = TextEditingController();
    final stockController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Inventory"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() {
                return webController.imageBytes.value != null
                    ? Image.memory(webController.imageBytes.value!, height: 150)
                    : const Image(
                        image: NetworkImage(
                            "https://cdni.iconscout.com/illustration/premium/thumb/product-is-empty-illustration-download-in-svg-png-gif-file-formats--no-records-list-record-emply-data-user-interface-pack-design-development-illustrations-6430781.png"),
                        height: 150,
                      );
              }),
              TextButton(
                onPressed: webController.pickImage,
                child: Obx(() => Text(
                      webController.imageBytes.value != null
                          ? "Change Image"
                          : "Select Image",
                      style: const TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    )),
              ),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Inventory Name"),
              ),
              TextField(
                controller: stockController,
                decoration: const InputDecoration(labelText: "Stock"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              webController.imageBytes.value = null;
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              final name = nameController.text.trim();
              final stock = stockController.text.trim();

              if (name.isNotEmpty &&
                  stock.isNotEmpty &&
                  webController.imageBytes.value != null) {
                await addProductCategoryWeb(
                  context,
                  name,
                  int.tryParse(stock) ?? 0,
                  webController.imageBytes.value!,
                );
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Fill all fields and select an image.")),
                );
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  static Future<void> addProductCategoryWeb(BuildContext context, String name,
      int stock, Uint8List imageBytes) async {
        showDialog(context: context, builder: (context) => const MyDialogBox());
    try {
      
      final uniqueId = const Uuid().v4();

      // Convert Uint8List to ByteData
      final byteData = ByteData.view(imageBytes.buffer);

      // Create CloudinaryFile using fromFutureByteData
      final file = await CloudinaryFile.fromFutureByteData(
        Future.value(byteData),
        identifier: webController.imageName.value,
        resourceType: CloudinaryResourceType.Image,
      );

      final response = await cloudinary.uploadFile(file);

      await _firestore.collection('Inventory').doc(uniqueId).set({
        'id': uniqueId,
        'Inventory_Name': name,
        'Stock': stock,
        'imageUrl': response.secureUrl,
      });

      webController.imageBytes.value = null;
      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Upload successful!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  static Future<void> deleteProductCategory(String uniqueId) async {
    await _firestore.collection('Inventory').doc(uniqueId).delete();
  }
}
