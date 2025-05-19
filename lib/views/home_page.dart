import 'package:flutter/material.dart';

import '../models/category.dart';
import '../services/api_service.dart';
import 'product_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery = '';
  Category? selectedCategory;
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  void fetchCategories() async {
    categories = await ApiService.fetchCategories();
    setState(() {});
  }

  void onSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => ProductListPage(
              searchQuery: searchQuery,
              categoryId: selectedCategory?.id,
            ),
      ),
    );
  }

  void onCategoryDrawerTap(Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                ProductListPage(title: category.name, categoryId: category.id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Onlayn apteka')),
      drawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 32,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                children: [
                  SizedBox(width: 64, child: Image.asset('assets/logo.png')),
                  Text(
                    'Onlayn dári dármaq ızlew sisteması ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(height: 1, color: Colors.black12),
            ...categories.map(
              (category) => ListTile(
                title: Text(category.name),
                trailing: Icon(Icons.arrow_right),
                onTap: () => onCategoryDrawerTap(category),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Dári ati yamasa dárixananiń  ati',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onChanged: (value) => searchQuery = value,
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Category>(
                    hint: Row(
                      children: [
                        Icon(Icons.category),
                        SizedBox(width: 8),
                        Text('Dári kategoriyası'),
                      ],
                    ),
                    value: selectedCategory,
                    isExpanded: true,
                    icon: Icon(Icons.arrow_drop_down),
                    items:
                        categories
                            .map(
                              (c) => DropdownMenuItem(
                                value: c,
                                child: Text(c.name),
                              ),
                            )
                            .toList(),
                    onChanged:
                        (value) => setState(() => selectedCategory = value),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onSearch,
                  icon: Icon(Icons.search),
                  label: Text('Izlew'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
