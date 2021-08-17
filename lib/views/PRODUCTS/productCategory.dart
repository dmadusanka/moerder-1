import 'package:MOrder/views/PRODUCTS/productCatPreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:MOrder/controllers/productCategoriesController.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class productRangers extends StatelessWidget {

  final ProductCatagoriesController PCC = Get.put(ProductCatagoriesController());

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Select Product Category", style: TextStyle(
                        fontSize: 18.0
                    ),
                    ),
                  ),
                  IconButton(icon: Icon(
                      Icons.view_list_rounded),
                    onPressed: (){
                      print("DONE");
                    },
                  ),
                  IconButton(icon: Icon(
                      Icons.grid_view),
                    onPressed: (){
                      print("DONE");
                    },
                  )
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                if(PCC.isLoading.value)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else
                  return StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: PCC.prodictCategoriesList.length,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      itemBuilder: (context, index){
                        return ProductCatTile(PCC.prodictCategoriesList[index]);
                      },
                      staggeredTileBuilder: (index) => StaggeredTile.fit(1)
                  );
              }),
            )
          ],
        ),
      );
    }
}