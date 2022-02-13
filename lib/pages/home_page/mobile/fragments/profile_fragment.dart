import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileFragment extends StatelessWidget {
  const ProfileFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: context.primaryColor,
        title:
        Row(
          children: const [
            Icon(Icons.person),
            SizedBox(width: 10,),
            Text('My Profile'),
          ],
        ),
      ),
      backgroundColor: context.canvasColor,
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: context.primaryColor,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15))
              ),
              child: Column(
                children: [
                  const SizedBox(height: 15.0,),
                  VxCircle(
                    radius: 155.0,
                    customDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      border: Border.all(color: context.backgroundColor, width: 4)
                    ),
                    child: Image.asset("assets/images/profile.png", fit: BoxFit.fill),
                  ),
                  const SizedBox(height: 15,),
                  "Good morning".text.lg.semiBold.color(context.backgroundColor).make(),
                  "USER NAME".text.xl3.semiBold.color(context.backgroundColor).make(),
                  const SizedBox(height: 30,)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 255.0, bottom: 20),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: context.backgroundColor,
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(height: 20,),
                      "Account Info".text.xl3.semiBold.make().pLTRB(15.0, 10.0, 0.0, 4.0),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: context.canvasColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                VxCircle(
                                  radius: 50,
                                  backgroundColor: context.backgroundColor,
                                  child: const Icon(Icons.mail),
                                ),
                                const SizedBox(width: 10,),
                                Container(
                                  width: MediaQuery.of(context).size.width - 165,
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: context.backgroundColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "Email".text.bold.make().pOnly(left: 8.0),
                                      "usaere.gada@gmail.com".text.color(context.cardColor.withOpacity(0.7)).make().pOnly(left: 8.0),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                VxCircle(
                                  radius: 50,
                                  backgroundColor: context.backgroundColor,
                                  child: const Icon(Icons.phone),
                                ),
                                const SizedBox(width: 10,),
                                Container(
                                  width: MediaQuery.of(context).size.width - 165,
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: context.backgroundColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "Phone".text.bold.make(),
                                      "98843453443".text.color(context.cardColor.withOpacity(0.7)).make(),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                VxCircle(
                                  radius: 50,
                                  backgroundColor: context.backgroundColor,
                                  child: const Icon(Icons.location_on),
                                ),
                                const SizedBox(width: 10,),
                                Container(
                                  width: MediaQuery.of(context).size.width - 165,
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                    color: context.backgroundColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "Address".text.bold.make().pOnly(left: 8.0),
                                      "address of user which, city, 563424".text.color(context.cardColor.withOpacity(0.7)).make().pOnly(left: 8.0),
                                    ],
                                  ),
                                )
                              ]
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            child: "Edit Profile".text.semiBold.lg.color(context.backgroundColor).make(),
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(125, 35),
                              primary: context.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ).pOnly(left: 20),
                          ElevatedButton(
                            onPressed: () {},
                            child: "Sign Out".text.semiBold.lg.color(context.backgroundColor).make(),
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(125, 35),
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ).pOnly(right: 20),
                        ],
                      ).pOnly(bottom: 10),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
