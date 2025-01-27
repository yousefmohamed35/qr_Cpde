import 'package:flutter/material.dart';

class NotHasPermission extends StatelessWidget {
  const NotHasPermission({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 350,
        child: Card(
          elevation: 0,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt_outlined, size: 64),
                SizedBox(height: 16),
                Text('Permission to camera is needed '),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Check Permission"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
