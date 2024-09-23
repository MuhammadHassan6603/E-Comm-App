import 'package:ecomm/consts/consts.dart';
import 'package:ecomm/consts/lists.dart';
import 'package:ecomm/controller/product_controller.dart';
import 'package:ecomm/views/category_screen/category_details.dart';
import 'package:ecomm/views/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller=Get.put(ProductController());
    return bgWidget(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: categories.text.fontFamily(bold).white.make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisSpacing: 8,crossAxisSpacing: 8,mainAxisExtent: 200),
          itemBuilder: (context,index){
            return Column(
              children: [
                Image.asset(categoryImages[index],height: 120,width: 200,fit: BoxFit.cover,),
                10.heightBox,
                categoriesList[index].text.color(darkFontGrey).fontFamily(semibold).align(TextAlign.center).make()
              ],
            ).box.white.rounded.outerShadowXl.clip(Clip.antiAlias).make().onTap((){
              controller.getSubCategories(categoriesList[index]);
              Get.to(()=>CategoryDetails(title: categoriesList[index],));
            });
          }),
        ),
      )
    );
  }
}