import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/consts/consts.dart';
import 'package:ecomm/controller/cart_controller.dart';
import 'package:ecomm/services/firestore_services.dart';
import 'package:ecomm/views/widgets_common/our_button.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(CartController());
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Shopping Cart"
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(redColor),
                  ),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is empty".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context,int index){
                              return ListTile(
                                leading: Image.network('${data[index]['img']}'),
                                title: "${data[index]['title']} (${data[index]['qty']})".text.fontFamily(semibold).size(16).make(),
                                subtitle: "${data[index]['tprice']}".text.color(redColor).fontFamily(semibold).make(),
                                trailing: const Icon(Icons.delete,color: redColor,).onTap((){
                                  FirestoreServices.deleteDocument(data[index].id);
                                }),
                              );
                            }
                            )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total Price"
                              .text
                              .fontFamily(semibold)
                              .color(darkFontGrey)
                              .make(),
                          Obx(()=>"${controller.totalP.value}".text.fontFamily(semibold).color(redColor).make()),
                        ],
                      )
                          .box
                          .padding(const EdgeInsets.all(12))
                          .color(lightGolden)
                          .width(context.screenWidth - 60)
                          .roundedSM
                          .make(),
                      SizedBox(
                        width: context.screenWidth - 60,
                        child: ourButton(
                            onPress: () {},
                            color: redColor,
                            textColor: whiteColor,
                            title: "Proceed to Shipping"),
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}
