import 'package:flutter/material.dart';

Widget _buildActionButtons() {
  return Column(
    children: [
      ElevatedButton.icon(
        onPressed: () {
          // Handle ubah data button press
        },
        icon: const Icon(Icons.edit),
        label: const Text('Ubah Data'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 5,
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
      const SizedBox(height: 10),
      ElevatedButton.icon(
        onPressed: () {
          // Handle ganti password button press
        },
        icon: const Icon(Icons.lock),
        label: const Text('Ganti Password'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 5,
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
      const SizedBox(height: 10),
      ElevatedButton.icon(
        onPressed: () {
          // Handle logout button press
        },
        icon: const Icon(Icons.logout),
        label: const Text('Logout'),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          elevation: 5,
          minimumSize: const Size(double.infinity, 50),
        ),
      ),
    ],
  );
}
