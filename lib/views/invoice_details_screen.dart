import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invoice_generator/global_variables/product_data.dart';
import 'package:invoice_generator/global_variables/ui_components.dart';
import 'package:invoice_generator/views/common_widgets/text_field_widget.dart';

import 'common_widgets/text_widget.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  const InvoiceDetailsScreen({super.key});

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  /*
  Map<String, dynamic> hintText = {
    'Company': 'Mamaearth Ltd...',
    'Product': 'Mamaearth neem Fashwash...',
    'Quantity': '1,2,3...',
    'Price': '₹ 200',
    'Description':
        'Is oil your skin\'s arch enemy? Meet the perfect blend of skin BFFs that banish acne, blemishes & that extra shine by just being their natural & amazing self!',
  };
  */
  final _formKey = GlobalKey<FormState>();
  ProductData newProduct = ProductData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextWidget(
          fontSize: 18,
          title: 'Create new invoice',
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.check_rounded,
              size: 28,
            ),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              TextWidget(
                fontSize: 22,
                title: 'Invoice Details',
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
              const SizedBox(
                height: 40,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                      hint: 'Mamaearth Ltd...',
                      labelText: 'Company',
                      validatorVariable: newProduct.company,
                      validatorFunc: (value) {
                        return value!.isEmpty ? 'enter company name' : null;
                      },
                      saveData: (value) => newProduct.company = value,
                    ),
                    TextFieldWidget(
                      hint: 'Mamaearth neem Fashwash...',
                      labelText: 'Product',
                      validatorVariable: newProduct.product,
                      validatorFunc: (value) {
                        return value!.isEmpty ? 'enter product name' : null;
                      },
                      saveData: (value) => newProduct.product = value,
                    ),
                    TextFieldWidget(
                      labelText: 'Quantity',
                      hint: '1,2,3...',
                      validatorVariable: newProduct.quantity.toString(),
                      validatorFunc: (value) {
                        return value!.isEmpty ? 'enter quantity' : null;
                      },
                      saveData: (value) =>
                          newProduct.quantity = int.parse(value!),
                    ),
                    TextFieldWidget(
                      hint: '₹ 200',
                      labelText: 'Price',
                      validatorVariable: newProduct.price.toString(),
                      validatorFunc: (value) {
                        return value!.isEmpty ? 'enter product price' : null;
                      },
                      saveData: (value) =>
                          newProduct.price = double.parse(value!),
                    ),
                    TextFieldWidget(
                      hint:
                          'Is oil your skin\'s arch enemy? Meet the perfect blend of skin BFFs that banish acne, blemishes & that extra shine by just being their natural & amazing self!',
                      labelText: 'Description',
                      validatorVariable: newProduct.description,
                      validatorFunc: (value) {
                        return value!.isEmpty
                            ? 'enter product description'
                            : null;
                      },
                      saveData: (value) => newProduct.description = value,
                      maxline: 4,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // productList.add(newProduct)
                    newProduct.addToProductList();
                    Fluttertoast.showToast(msg: 'Product Added');

                    for (int i = 0; i < productList.length; i++) {
                      log('${productList[i].price}');
                    }
                    _formKey.currentState!.reset();
                    newProduct.reset();
                    setState(() {});
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // fixedSize: Size(double.infinity, 50),
                  // alignment: Alignment.center,
                  minimumSize: const Size(500, 50),
                ),
                child: TextWidget(
                  title: 'Add Another Product',
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
