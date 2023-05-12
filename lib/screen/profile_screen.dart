import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app_proyek/screen/currency_converter_screen.dart';
import 'package:news_app_proyek/screen/login_screen.dart';
import 'package:news_app_proyek/screen/testimonial_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> listWaktuBagian = <String>['WIB', 'WITA', 'WIT', 'UTC', 'JST'];
  late String waktuBagian = listWaktuBagian.first;
  late String timeString;
  late Timer timer;
  @override
  void initState() {
    timeString = _formatDateTime(DateTime.now());
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _getTime());
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          children: [
            ListTile(
              leading: ClipOval(
                child: Image.asset(
                  'assets/images/ImanAbdurrahman.jpg',
                ),
              ),
              title: const Text(
                'Iman Abdurrahman',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: const Text(
                '12320067',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const Divider(
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    timeString,
                    style: const TextStyle(fontSize: 25, fontFamily: 'Poppins'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: DropdownButton<String>(
                    underline: Container(),
                    value: waktuBagian,
                    elevation: 16,
                    onChanged: (String? value) {
                      setState(() {
                        waktuBagian = value!;
                      });
                    },
                    items: listWaktuBagian
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 25, fontFamily: 'Poppins'),
                        ),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Padding(
                      padding: EdgeInsets.fromLTRB(5, 5, 8, 8),
                      child: Icon(
                        Icons.note_alt,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    title: const Text(
                      'Kesan dan Pesan',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TestimonialScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Padding(
                      padding: EdgeInsets.fromLTRB(5, 5, 8, 8),
                      child: Icon(
                        Icons.attach_money,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    title: const Text(
                      'Konversi Mata Uang',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CurrencyConventerScreen(),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Padding(
                      padding: EdgeInsets.fromLTRB(5, 12, 8, 8),
                      child: Icon(
                        Icons.logout,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                    title: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Keluar',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    onTap: () async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.remove('rememberLogin');
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _getTime() {
    DateTime waktu;
    if (waktuBagian == 'WITA') {
      waktu = DateTime.now().add(const Duration(hours: 1));
    } else if (waktuBagian == 'WIT') {
      waktu = DateTime.now().add(const Duration(hours: 2));
    } else if (waktuBagian == 'UTC') {
      waktu = DateTime.now().toUtc();
    } else if (waktuBagian == 'JST') {
      waktu = DateTime.now().toUtc().add(const Duration(hours: 9));
    } else {
      waktu = DateTime.now();
    }

    final String formattedDateTime = _formatDateTime(waktu);
    setState(() {
      timeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy kk:mm:ss').format(dateTime);
  }
}
