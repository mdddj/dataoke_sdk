import 'dart:convert';

import 'package:dataoke_sdk/blog/base_api.dart';
import 'package:dataoke_sdk/blog/blog_model.dart';

/// 博客相关接口。
class BlogService {
  final BaseBlogApiUtil util = BaseBlogApiUtil();

  BlogService._();
  factory BlogService() => BlogService._();

  /*
    |--------------------------------------------------------------------------
    | 获取博客列表
    |
    | [page] - 第几页,(需要从第一页开始)
    | [pageSize] - 每页几条数据
    | 
    |--------------------------------------------------------------------------
  */
  Future<BlogList?> getBlogList(int page, int pageSize) async {
    final data = <String, dynamic>{'page': page, 'pageSize': pageSize};
    final response = await util.get('/api/blog/list', data: data);
    if (response.isNotEmpty) {
      return BlogList.fromJson(jsonDecode(response));
    }
    return null;
  }
}
