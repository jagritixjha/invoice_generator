import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:invoice_generator/global_variables/product_data.dart';
import 'package:invoice_generator/global_variables/ui_components.dart';
import 'package:invoice_generator/views/common_widgets/text_widget.dart';
import 'package:invoice_generator/views/invoice_details_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart%20';
import 'package:pdf/widgets.dart' as pw;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double totalPrice(List productList) {
    double totalPrice = 0;
    totalPrice += productList.first['price'];
    return totalPrice;
  }

  Future<void> downloadPdf(Map product) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        build: (pw.Context context) => [
          pw.Header(
            level: 0,
            child: pw.Text(
              'Invoice',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
            ),
          ),
          ...invoice.map(
            (transaction) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Company: \t ${product['company']}',
                  style: pw.TextStyle(
                      fontSize: 10, fontWeight: pw.FontWeight.bold, height: 2),
                ),
                pw.SizedBox(height: 10),
                pw.Row(children: [
                  pw.Text(
                    'Date: \t ${DateTime.now().toString().substring(0, 10)}',
                    style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                        height: 2),
                  ),
                  pw.SizedBox(width: 50),
                  pw.Text(
                    'Purchase Date: \t ${DateTime.now().toString().substring(0, 10)}',
                    style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                        height: 2),
                  ),
                ]),
                pw.Divider(color: PdfColors.blueGrey200),
                pw.SizedBox(height: 10),
                pw.Text(
                  'Transaction Details',
                  style: pw.TextStyle(
                    fontSize: 18,
                    fontWeight: pw.FontWeight.bold,
                    height: 2,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.TableHelper.fromTextArray(
                  context: context,
                  border: null,
                  headerStyle: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, color: PdfColors.grey800),
                  headerDecoration:
                      pw.BoxDecoration(color: PdfColors.indigo100),
                  cellHeight: 30,
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerRight,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                  },
                  headers: [
                    'Company',
                    'Product',
                    'Description',
                    'Quantity',
                    'Price'
                  ],
                  data: transaction
                      .map((product) => [
                            product['company'],
                            product['product'],
                            product['description'],
                            product['quantity'].toString(),
                            '\$${(product['price'] * product['quantity']).toStringAsFixed(2)}',
                          ])
                      .toList(),
                ),
                pw.Divider(color: PdfColors.blueGrey200),
                // pw.Spacer(),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Text(
                      'Total: \$${transaction.fold(0, (num sum, item) => sum + (item['price'] * item['quantity'])).toStringAsFixed(2)}',
                      style: pw.TextStyle(
                          fontSize: 14, fontWeight: pw.FontWeight.bold),
                    ),
                  ],
                ),
                pw.SizedBox(height: 20),
              ],
            ),
          ),
        ],
        pageFormat: PdfPageFormat.a4,
      ),
    );
    final directory = await getTemporaryDirectory();
    final file = File('${directory!.path}/invoice.pdf');
    await file.writeAsBytes(await pdf.save());
    log(directory.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          fontSize: 22,
          title: 'Invoice App',
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
        // centerTitle: true,
        actions: const [
          CircleAvatar(
            backgroundImage: NetworkImage(
                'https://i.pinimg.com/474x/6f/6a/12/6f6a126051cd43a9a3dfa417b5903762.jpg'),
            radius: 20,
          ),
          SizedBox(
            width: 18,
          ),
        ],
      ),
      body: invoice.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/invoice.png'),
                  TextWidget(
                    title: '\nYou Have No Invoice To Show.',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                  TextWidget(
                    title: 'Create one Now!',
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const InvoiceDetailsScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      minimumSize: const Size(100, 50),
                    ),
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    label: TextWidget(
                      title: 'Add Invoice',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: invoice.length,
                      itemBuilder: (context, index) {
                        final product = invoice[index].first;
                        return Container(
                          height: 120,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18, vertical: 18),
                          decoration: BoxDecoration(
                            color: Colors.indigo.shade50,
                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade200, blurRadius: 16)
                            ],
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                height: 150,
                                width: 80,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                decoration: const BoxDecoration(
                                  color: Colors.white70,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                child: Image.asset(
                                  'assets/images/bill.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(
                                    TextSpan(
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                      children: [
                                        TextSpan(text: product['product']),
                                        TextSpan(
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                          text: invoice.first.length <= 1
                                              ? ''
                                              : ' + ${invoice.first.length}',
                                        ),
                                        // TextSpan(
                                        //   style: const TextStyle(
                                        //       fontSize: 16,
                                        //       color: Colors.black54,
                                        //       fontWeight: FontWeight.w500),
                                        //   text: '\nFrom -',
                                        // ),
                                        const TextSpan(
                                          style: TextStyle(
                                              fontSize: 16,
                                              height: 1.6,
                                              color: Colors.black54,
                                              fontWeight: FontWeight.w500),
                                          text: '\nDMart',
                                        ),
                                        TextSpan(
                                          style: const TextStyle(
                                            fontSize: 14,
                                            height: 1.2,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          text:
                                              '\n${totalPrice(invoice.first)}',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  downloadPdf(product);
                                },
                                icon: const Icon(Icons.save_alt_outlined),
                              ),
                              IconButton(
                                onPressed: () {
                                  invoice.removeAt(index);
                                  setState(() {});
                                },
                                icon: const Icon(Icons.delete_outline_outlined),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
    );
  }
}
