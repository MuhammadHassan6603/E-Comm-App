import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecomm/consts/consts.dart';
import 'package:ecomm/controller/product_controller.dart';
import 'package:ecomm/services/firestore_services.dart';
import 'package:ecomm/views/category_screen/item_details.dart';
import 'package:ecomm/views/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatelessWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var controller=Get.find<ProductController>();
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: title!.text.fontFamily(bold).white.make(),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getProducts(title),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(redColor),
                )
              );
            }else if(snapshot.data!.docs.isEmpty){
              return Center(
                child: "No Products Found!".text.color(darkFontGrey).make(),
              );
            }else{
              var data=snapshot.data!.docs;
              return Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: List.generate(
                    controller.subcat.length,
                    (index) => "${controller.subcat[index]}"
                        .text
                        .size(12)
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .makeCentered()
                        .box
                        .white
                        .rounded
                        .size(150, 60)
                        .margin(const EdgeInsets.symmetric(horizontal: 4))
                        .make()
                  ),
                ),
              ),
              20.heightBox,

              Expanded(child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 250,mainAxisSpacing: 8,crossAxisSpacing: 8),
                itemBuilder: (context,index){
                   return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(data[index]['p_imgs'][0],height: 150, width: 200,fit: BoxFit.cover,),
                              10.heightBox,
                              "${data[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                              10.heightBox,
                              "Rs ${data[index]['p_price']}".text.color(redColor).fontFamily(bold).size(16).make()
                            ],
                          ).box.white.outerShadowMd.margin(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(const EdgeInsets.all(12)).make().onTap((){
                            Get.to(()=> ItemDetails(title: "${data[index]['p_name']}",data: data[index],));
                          });
                }
                ))
            ],
          ),
        );
            }
          }
          )
      ),
    );
  }
}
