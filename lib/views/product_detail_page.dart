import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/api_service.dart';

class ProductDetailPage extends StatelessWidget {
  final String title;
  final int productId;

  const ProductDetailPage({required this.title, required this.productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: FutureBuilder<Product>(
        future: ApiService.fetchProductById(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Dari darmaq tabilmadi.'));
          }

          final product = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product.image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (context, error, stackTrace) => Icon(
                          Icons.image_not_supported,
                          size: 100,
                          color: Colors.grey,
                        ),
                  ),
                ),
                SizedBox(height: 16),

                // Name
                Text(
                  product.name,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),

                // Info Cards
                Card(
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Icon(Icons.attach_money),
                    title: Text('Senasi'),
                    subtitle: Text('${product.price}'),
                  ),
                ),
                Card(
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('Manzili'),
                    subtitle: Text(product.location),
                  ),
                ),
                Card(
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Icon(Icons.phone),
                    title: Text('Telefon nomeri'),
                    subtitle: Text(product.phoneNumber),
                    onTap: () {
                      // Optional: launch phone call
                    },
                  ),
                ),
                Card(
                  elevation: 2,
                  margin: EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('Saqlaw muddeti'),
                    subtitle: Text(product.expirationDate),
                  ),
                ),

                // Description
                Text(product.description, style: TextStyle(fontSize: 16)),
                SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
