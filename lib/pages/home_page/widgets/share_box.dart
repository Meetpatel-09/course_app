import 'package:flutter/material.dart';

class ShareBox extends StatelessWidget {
  const ShareBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: const BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 100, child: Text('Share with Friends', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),)),
          ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                shape: const StadiumBorder(),
              ),
              child: const Text('Share', style: TextStyle(color: Colors.blueGrey),)),
        ],
      ),
    );
  }
}
