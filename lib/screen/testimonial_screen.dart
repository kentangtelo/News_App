import 'package:flutter/material.dart';

import '../utils/utils.dart';

class TestimonialScreen extends StatelessWidget {
  const TestimonialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        title: Text(
          'Kesan dan Pesan',
          style: titleHeader,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Kesan',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Pembelajaran mata kuliah tpm mudah diikuti dan dimengerti, karena dosen memberikan penjelasan dengan baik',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Pesan',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Kekurangan/kesalahan yang sudah terjadi mohon diperbaiki',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
