import 'package:coding_hands/model/product_model.dart';
import 'package:coding_hands/pages/product_details_screen.dart';
import 'package:coding_hands/provider/brand_section_provider.dart';
import 'package:coding_hands/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text(
          'Coding Hands',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
        ],
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.notifications_none)),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
      body: Consumer2<ProductProvider, BrandSelectionProvider>(
        builder: (context, productProvider, brandSelectionProvider, _) {
          if (productProvider.product == null) {
            // If product is null, fetch data
            productProvider.fetchProducts();
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (productProvider.product!.products.isEmpty) {
            // If products list is empty, display message
            return const Center(
              child: Text('No products available'),
            );
          } else {
            // If products are available, display the list
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
                child: Column(
                  children: [
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: SizedBox(
                            child: Image.network(
                              productProvider.product!.products[0].thumbnail,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16, bottom: 16),
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 40,
                                  child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: _buildBrandContainers(
                                      productProvider.product!.products,
                                      brandSelectionProvider.selectedBrand,
                                      brandSelectionProvider.setSelectedBrand,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productProvider.product!.products.length,
                      itemBuilder: (context, index) {
                        final productElement =
                            productProvider.product!.products[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(
                                    product: productElement),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: SizedBox(
                                    height: 200,
                                    width: double.infinity,
                                    child: Image.network(
                                      productProvider
                                          .product!.products[index].thumbnail,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 80,
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )),
                                      Text(
                                        '${productElement.rating}',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                                Positioned(
                                  top: 130,
                                  left: 0,
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    height: 100,
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15)),
                                      border: Border.all(
                                        color: const Color(0xFFEEE6E6),
                                        width: 1.0,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          productProvider
                                              .product!.products[index].title,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '\$ ${productElement.price.toStringAsFixed(0)} ',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF828282)),
                                            ),
                                            const Icon(
                                              Icons.fiber_manual_record,
                                              size: 6,
                                              color: Color(0xFF828282),
                                            ),
                                            Text(
                                              ' ${productElement.discountPercentage}% Off',
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Color(0xFF828282)),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  List<Widget> _buildBrandContainers(
    List<ProductElement> products,
    String? selectedBrand,
    void Function(String?) setSelectedBrand,
  ) {
    // Set to store encountered brand names
    final Set<String> encounteredBrands = {};
    // List to store brand containers
    final List<Widget> brandContainers = [];

    // Add "All" option as the first element
    brandContainers.add(
      _buildBrandContainer(
        'All',
        selectedBrand == null,
        () => setSelectedBrand(null),
      ),
    );

    // Iterate through the list of products
    for (final productElement in products) {
      final brand = productElement.brand;
      // Check if the brand is not already encountered
      if (!encounteredBrands.contains(brand)) {
        // If not, add it to the set and create a brand container
        encounteredBrands.add(brand);
        brandContainers.add(
          _buildBrandContainer(
            brand,
            brand == selectedBrand,
            () => setSelectedBrand(brand),
          ),
        );
      }
    }
    return brandContainers;
  }

  Widget _buildBrandContainer(
      String brand, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFEEE6E6), width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
            color: isSelected ? const Color(0xFFE8D6FF) : Colors.white),
        child: Text(
          brand,
          style: TextStyle(
            fontFamily: "Roboto",
            color: isSelected ? const Color(0xFF4E00AF) : Colors.black,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
