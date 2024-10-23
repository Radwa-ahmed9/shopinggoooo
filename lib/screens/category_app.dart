import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:store_app/services/get_all_categories_service.dart';
import 'package:store_app/screens/category_products_page.dart'; // Make sure the path is correct

class HomeApp extends StatelessWidget {
  HomeApp({Key? key}) : super(key: key);

  static String id = 'HomeApp';

  // Define a map of category names and icons
  final Map<String, IconData> categoryIcons = {
    'electronics': FontAwesomeIcons.tv,
    'men\'s clothing': FontAwesomeIcons.male,
    'women\'s clothing': FontAwesomeIcons.female,
    'jewelery': FontAwesomeIcons.gem,
    // Add more categories and icons as needed
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.cartPlus,
              color: Colors.black,
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Categories',
          style: TextStyle(
            color: Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
        child: FutureBuilder<List<dynamic>>(
          future: GetAllCategoriesService().getAllCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic> categories = snapshot.data!;
              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  String categoryName = categories[index].toString().toLowerCase();

                  // Get the corresponding icon for the category
                  IconData categoryIcon = categoryIcons[categoryName] ??
                      FontAwesomeIcons.box; // Default icon if not found

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryProductsPage(
                            categoryName: categoryName,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(
                              categoryIcon,
                              size: 30,
                              color: Colors.cyan.shade600, // Customize icon color
                            ),
                            SizedBox(width: 20), // Spacing between icon and text
                            Text(
                              categories[index],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold, // Make the font bold
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
