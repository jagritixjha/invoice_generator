import 'package:flutter/material.dart';
import 'package:invoice_generator/global_variables/ui_components.dart';
import 'package:invoice_generator/views/common_widgets/text_widget.dart';
import 'package:invoice_generator/views/invoice_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: Center(
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
      ),
    );
  }
}
