import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/consts/consts.dart';
import 'package:ecomm/consts/lists.dart';
import 'package:ecomm/controller/auth_controller.dart';
import 'package:ecomm/controller/profile_controller.dart';
import 'package:ecomm/services/firestore_services.dart';
import 'package:ecomm/views/auth_screen/login_screen.dart';
import 'package:ecomm/views/profile_screen/components/details_card.dart';
import 'package:ecomm/views/profile_screen/components/edit_profile_screen.dart';
import 'package:ecomm/views/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
                stream: FirestoreServices.getUser(currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      ),
                    );
                  } else {
                    var data = snapshot.data!.docs[0];
                    return SafeArea(
                        child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.all(8.0)),
                        ListTile(
                          leading: data['imageUrl']==''?Image.asset(
                            profileimg,
                            width: 90,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make():
                          Image.network(
                            data['imageUrl'],
                            width: 90,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                          title: "${data['name']}"
                              .text
                              .fontFamily(semibold)
                              .white
                              .make(),
                          subtitle: "${data['email']}".text.white.make(),
                          trailing: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero),
                                  side: const BorderSide(color: whiteColor)),
                              onPressed: () async {
                                await Get.put(AuthController())
                                    .signoutMethod(context);
                                Get.offAll(() => const LoginScreen());
                              },
                              child: 'Logout'
                                  .text
                                  .fontFamily(semibold)
                                  .white
                                  .make()),
                        ),
                        10.heightBox,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero),
                                    side: const BorderSide(color: whiteColor)),
                                onPressed: () {
                                  controller.nameController.text = data['name'];
                                  
                                  Get.to(() => EditProfileScreen(
                                        data: data,
                                      ));
                                },
                                child: 'Edit Profile'
                                    .text
                                    .fontFamily(semibold)
                                    .white
                                    .make()),
                          ),
                        ),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            detailsCard(
                                count: data['cart_count'],
                                title: 'in your cart',
                                width: context.screenWidth / 3.4),
                            detailsCard(
                                count: data['wishlist_count'],
                                title: 'in your wishlist',
                                width: context.screenWidth / 3.4),
                            detailsCard(
                                count: data['order_count'],
                                title: 'your orders',
                                width: context.screenWidth / 3.4),
                          ],
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return const Divider(color: lightGrey);
                          },
                          itemCount: profileButtonsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: Image.asset(
                                profileButtonsIcon[index],
                                width: 21,
                              ),
                              title: profileButtonsList[index]
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                            );
                          },
                        )
                            .box
                            .white
                            .margin(const EdgeInsets.all(12))
                            .padding(const EdgeInsets.symmetric(horizontal: 16))
                            .rounded
                            .shadowSm
                            .make()
                            .box
                            .color(redColor)
                            .make(),
                      ],
                    ));
                  }
                })));
  }
}
