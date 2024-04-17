import 'package:ecom_2/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ecom_2/app/routes/app_pages.dart';
import 'package:ecom_2/app/utils/memoryManagement.dart';

class AdminProfileView extends GetView<ProfileController> {
  const AdminProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4eADF),
      appBar: AppBar(
        backgroundColor: Color(0XFFF4EADF),
        title: Text(
          'Profile',
          style: GoogleFonts.gabarito(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 120,
                  width: 120,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Text(
                      (controller.user!.fullName![0].toUpperCase() ?? '') +
                          (controller.user!.fullName![1].toUpperCase() ?? ''),
                      style: TextStyle(
                        fontSize: 50,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildField(
                  icon: Icons.phone,
                  label: 'Phone Number',
                  value: controller.user?.phoneNumber ?? '',
                ),
                _buildField(
                  icon: Icons.email,
                  label: 'Email',
                  value: controller.user?.email ?? '',
                ),
                _buildField(
                  icon: Icons.person,
                  label: 'Name',
                  value: controller.user?.fullName ?? '',
                ),
                SizedBox(
                  height: 30,
                ),
                FloatingActionButton.extended(
                  onPressed: () {
                    Get.toNamed(Routes.EDITPROFILE);
                  },
                  backgroundColor: Colors.white,
                  foregroundColor: Color(0xff002244),
                  label: Text('Edit Profile'),
                  icon: Icon(Icons.edit),
                ),
                SizedBox(height: 20),
                FloatingActionButton.extended(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: Color(0xff002244),
                        content: Text(
                          'Are you sure you want to logout?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xfff4eadf),
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'No',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xfff4eadf),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              MemoryManagement.removeAll();
                              Get.offAllNamed(Routes.LOGIN);
                            },
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.red,
                  label: Text('Logout'),
                  icon: Icon(Icons.logout),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildField(
      {required IconData icon, required String label, required String value}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 10),
          Text(
            label + ': ' + value,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
