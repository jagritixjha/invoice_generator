import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:invoice_generator/global_variables/product_data.dart';
import 'package:invoice_generator/global_variables/ui_components.dart';
import 'package:invoice_generator/views/common_widgets/text_field_widget.dart';
import 'package:invoice_generator/views/home_screen.dart';

import 'common_widgets/text_widget.dart';

class InvoiceDetailsScreen extends StatefulWidget {
  const InvoiceDetailsScreen({super.key});

  @override
  State<InvoiceDetailsScreen> createState() => _InvoiceDetailsScreenState();
}

class _InvoiceDetailsScreenState extends State<InvoiceDetailsScreen> {
  final _formKey = GlobalKey<FormState>();

  String? company, product, description;
  int? quantity;
  double? price;
  void resetVar() {
    price = company = description = product = quantity = null;
  }

  void saveData() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      ProductData finalProduct = ProductData(
        price: price,
        company: company,
        description: description,
        product: product,
        quantity: quantity,
      );
      finalProduct.getProductList();
      Fluttertoast.showToast(msg: 'Product Added');

      _formKey.currentState!.reset();
      finalProduct.reset();
      resetVar();
      for (var i in productList) {
        log('$i');
      }
      setState(() {});
    }
  }

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
        forceMaterialTransparency: true,
        actions: [
          IconButton(
            onPressed: () async {
              saveData();
              invoice.add(List.from(productList));
              log('$invoice');
              productList.clear();
              await showDialog(
                context: context,
                builder: (context) => SimpleDialog(
                  // title:
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                  children: [
                    CircleAvatar(
                      radius: 34,
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        'assets/images/done.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(bottom: 20, top: 18),
                      child: TextWidget(
                        title: 'Invoice Generated',
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              );
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
              setState(() {});
            },
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
                height: 34,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFieldWidget(
                      hint: 'Mamaearth Ltd...',
                      labelText: 'Company',
                      validatorVariable: company,
                      validatorFunc: (value) {
                        return value!.isEmpty ? 'enter company name' : null;
                      },
                      saveData: (value) => company = value,
                    ),
                    TextFieldWidget(
                      hint: 'Mamaearth neem Fashwash...',
                      labelText: 'Product',
                      validatorVariable: product,
                      validatorFunc: (value) {
                        return value!.isEmpty ? 'enter product name' : null;
                      },
                      saveData: (value) => product = value,
                    ),
                    TextFieldWidget(
                      labelText: 'Quantity',
                      hint: '1,2,3...',
                      validatorVariable: quantity?.toString() ?? '',
                      validatorFunc: (value) {
                        return value!.isEmpty ? 'enter quantity' : null;
                      },
                      saveData: (value) => quantity = int.parse(value!),
                    ),
                    TextFieldWidget(
                      hint: '₹ 200',
                      labelText: 'Price',
                      validatorVariable: price?.toString() ?? '',
                      validatorFunc: (value) {
                        return value!.isEmpty ? 'enter product price' : null;
                      },
                      saveData: (value) => price = double.parse(value!),
                    ),
                    TextFieldWidget(
                      hint:
                          'Is oil your skin\'s arch enemy? Meet the perfect blend of skin BFFs that banish acne, blemishes & that extra shine by just being their natural & amazing self!',
                      labelText: 'Description',
                      validatorVariable: description,
                      validatorFunc: (value) {
                        return value!.isEmpty
                            ? 'enter product description'
                            : null;
                      },
                      saveData: (value) => description = value,
                      maxline: 4,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  saveData();
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
