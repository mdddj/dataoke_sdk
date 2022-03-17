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

  /// 获取字典模型对象
  /// params [key] : 字典的key
  /// params [password] : 部分字典是加密的,需要传递一个密码给后台解密才能获取数据, 密码被加盐后存储
  Future<dynamic> getTextModel(String key, {String? password}) async {
    final data = <String, dynamic>{'name': key};
    if (password != null) {
      data['viewPassword'] = password;
    }
    final response = await util.get('/api/blog/text', data: data);
    return response;
  }

  /// 发布一篇新博客
  Future<void> pishNewBlog(String title, String content, List<String> tags, String categoryId, {String? alias}) async {
    await util.post('/api/blog/push-new',data: {'title': title, 'content': content, 'tags': tags, 'categoryId': categoryId,'alias':alias??''});
  }

  /// 获取基本信息集合
  /// 有标签
  /// 有分类
  /// 有日期分类统计等数据
  Future<Map<String,dynamic>> getStatistics() async {
    final jsonString = await util.get('/api/blog/statistics');
    return jsonString.isNotEmpty ? jsonDecode(jsonString) : {};
  }
}
