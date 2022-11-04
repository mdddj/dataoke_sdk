



import 'package:dd_js_util/dd_js_util.dart';

///美团领券
class MeiTuanQuanApi extends BaseApi {
  MeiTuanQuanApi(): super('/api/zhe/mt/tg');
  set actId(String value) => params['actId'] = value; //2
  set linkType(String value) => params['linkType'] = value;//1
  set miniCode(String value) => params['miniCode'] = value;//1
}


///获取所有的分类列表
class ResourceCategoryListAllApi extends BaseApi {
  ResourceCategoryListAllApi() : super('/api/res/cates');
}

/// 获取博客列表
class BlogListApi extends BaseApi {
  BlogListApi(): super('/api/blog/list');
  set page(int page) => params['page'] = page;
  set pageSize(int pageSize) => params['pageSize'] = pageSize;

}