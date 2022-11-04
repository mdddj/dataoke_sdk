import '../dd_taoke_sdk.dart';
import '../model/category.dart';
import '../model/product.dart';
import 'package:flutter/material.dart';

abstract class BasePage<T extends StatefulWidget> extends State<T> {
  List<Category> categorys = <Category>[];

  int page = 1;
  int pageSize = 10;
  List<Product> products = <Product>[];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      afterLayout(context);
      loadCategory();
      getProductRequest(page, pageSize).then(addNewProducts);
    });
  }

  void loadCategory() {
    DdTaokeSdk.instance.getCategorys().then((value) {
      if (mounted) {
        setState(() {
          categorys.addAll(value);
        });
      }
    });
  }

  // 更新商品列表
  void addNewProducts(List<Product> newProducts) {
    if (mounted) {
      setState(() {
        products.addAll(newProducts);
      });
    }
  }

  // 获取商品列表的请求
  Future<List<Product>> getProductRequest(int page, int size);

  // 刷新
  Future<void> refresh() async {
    setState(() {
      page = 1;
      products.clear();
    });
    addNewProducts(await getProductRequest(page, pageSize));
  }

  // 下一页
  Future<void> loadMore() async {
    final nextPage = page + 1;
    addNewProducts(await getProductRequest(page, pageSize));
    if (mounted) {
      setState(() {
        page = nextPage;
      });
    }
  }

  void afterLayout(BuildContext context);
}
