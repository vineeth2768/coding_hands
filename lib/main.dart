import 'package:coding_hands/pages/product_screen.dart';
import 'package:coding_hands/provider/brand_section_provider.dart';
import 'package:coding_hands/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
        ),
        ChangeNotifierProvider(create: (context) => BrandSelectionProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coding Hands',
        theme: ThemeData(fontFamily: "Manrope"),
        home: const ProductScreen(),
      ),
    );
  }
}
