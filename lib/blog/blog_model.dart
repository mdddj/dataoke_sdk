import 'dart:convert';

import 'package:dd_js_util/dd_js_util.dart';


/// 博客列表返回结果模型
class BlogList {
  BlogList({
    required this.page,
    required this.list,
  });

  factory BlogList.fromJson(Map<String, dynamic> jsonRes) {
    final List<Blog>? list = jsonRes['list'] is List ? <Blog>[] : null;
    if (list != null) {
      for (final dynamic item in jsonRes['list']!) {
        if (item != null) {
          tryCatch(() {
            list.add(Blog.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return BlogList(
      page: JpaPageObject.fromJson(asT<Map<String, dynamic>>(jsonRes['page'])!),
      list: list!,
    );
  }

  JpaPageObject page;
  List<Blog> list;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'page': page,
        'list': list,
      };

  BlogList copy() {
    return BlogList(
      page: page.copy(),
      list: list.map((Blog e) => e.copy()).toList(),
    );
  }
}

/// jpa 分页返回对象模型
class JpaPageObject {
  JpaPageObject({
    required this.total,
    required this.currentPage,
    required this.pageSize,
    required this.maxPage,
    required this.hasPrevious,
    required this.paged,
  });

  factory JpaPageObject.fromJson(Map<String, dynamic> jsonRes) => JpaPageObject(
        total: asT<int>(jsonRes['total'])!,
        currentPage: asT<int>(jsonRes['currentPage'])!,
        pageSize: asT<int>(jsonRes['pageSize'])!,
        maxPage: asT<int>(jsonRes['maxPage'])!,
        hasPrevious: asT<bool>(jsonRes['hasPrevious'])!,
        paged: asT<bool>(jsonRes['paged'])!,
      );

  int total;
  int currentPage;
  int pageSize;
  int maxPage;
  bool hasPrevious;
  bool paged;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'total': total,
        'currentPage': currentPage,
        'pageSize': pageSize,
        'maxPage': maxPage,
        'hasPrevious': hasPrevious,
        'paged': paged,
      };

  JpaPageObject copy() {
    return JpaPageObject(
      total: total,
      currentPage: currentPage,
      pageSize: pageSize,
      maxPage: maxPage,
      hasPrevious: hasPrevious,
      paged: paged,
    );
  }
}

/// 博客模型
class Blog {
  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.createTime,
    required this.blogCategory,
    required this.author,
    this.thumbnail,
    required this.dateString,
    required this.tags,
    this.aliasString,
  });

  factory Blog.fromJson(Map<String, dynamic> jsonRes) {
    final List<Tags>? tags = jsonRes['tags'] is List ? <Tags>[] : null;
    if (tags != null) {
      for (final dynamic item in jsonRes['tags']!) {
        if (item != null) {
          tryCatch(() {
            tags.add(Tags.fromJson(asT<Map<String, dynamic>>(item)!));
          });
        }
      }
    }
    return Blog(
      id: asT<int>(jsonRes['id'])!,
      title: asT<String>(jsonRes['title'])!,
      content: asT<String>(jsonRes['content'])!,
      createTime: asT<int>(jsonRes['createTime'])!,
      blogCategory:
          BlogCategory.fromJson(asT<Map<String, dynamic>>(jsonRes['BlogCategory'])!),
      author: asT<String>(jsonRes['author'])!,
      thumbnail: asT<String?>(jsonRes['thumbnail']),
      dateString: asT<String>(jsonRes['dateString'])!,
      tags: tags!,
      aliasString: asT<String?>(jsonRes['aliasString']),
    );
  }

  int id;
  String title;
  String content;
  int createTime;
  BlogCategory blogCategory;
  String author;
  String? thumbnail;
  String dateString;
  List<Tags> tags;
  String? aliasString;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'title': title,
        'content': content,
        'createTime': createTime,
        'BlogCategory': BlogCategory,
        'author': author,
        'thumbnail': thumbnail,
        'dateString': dateString,
        'tags': tags,
        'aliasString': aliasString,
      };

  Blog copy() {
    return Blog(
      id: id,
      title: title,
      content: content,
      createTime: createTime,
      blogCategory: blogCategory.copy(),
      author: author,
      thumbnail: thumbnail,
      dateString: dateString,
      tags: tags.map((Tags e) => e.copy()).toList(),
      aliasString: aliasString,
    );
  }
}

class BlogCategory {
  BlogCategory({
    required this.id,
    required this.name,
    required this.logo,
    required this.intro,
    this.createTime,
  });

  factory BlogCategory.fromJson(Map<String, dynamic> jsonRes) => BlogCategory(
        id: asT<int>(jsonRes['id'])!,
        name: asT<String>(jsonRes['name'])!,
        logo: asT<String>(jsonRes['logo'])!,
        intro: asT<String>(jsonRes['intro'])!,
        createTime: asT<Object?>(jsonRes['createTime']),
      );

  int id;
  String name;
  String logo;
  String intro;
  Object? createTime;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'logo': logo,
        'intro': intro,
        'createTime': createTime,
      };

   BlogCategory copy() {
    return BlogCategory(
      id: id,
      name: name,
      logo: logo,
      intro: intro,
      createTime: createTime,
    );
  }
}

class Tags {
  Tags({
    required this.id,
    required this.name,
  });

  factory Tags.fromJson(Map<String, dynamic> jsonRes) => Tags(
        id: asT<int>(jsonRes['id'])!,
        name: asT<String>(jsonRes['name'])!,
      );

  int id;
  String name;

  @override
  String toString() {
    return jsonEncode(this);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
      };

  Tags copy() {
    return Tags(
      id: id,
      name: name,
    );
  }
}
