import 'dart:io';

import 'package:MOrder/services/remort_services.dart';
import 'package:get/state_manager.dart';
import 'package:MOrder/models/productCatagories.dart';

class ProductCatagoriesController extends GetxController{
  var isLoading = true.obs;
  var prodictCategoriesList = List<Product>().obs;

  @override
  void onInit() {
    fetchProductCategories();
    super.onInit();
  }

  void fetchProductCategories() async{
    try{
      isLoading(true);
      var PC = await RemoteService.fetchProductCategories();
      if(PC != null){
        prodictCategoriesList.value = PC;
      }
    }finally{
      isLoading(false);
    }
  }
}