// Dart imports:
import 'dart:convert';
import 'dart:developer';

class FFConvert {
  FFConvert._();

  static T? convert<T extends Object?>(dynamic value) {
    if (value == null) {
      return null;
    }
    return json.decode(value.toString()) as T?;
  }
}

T? asT<T extends Object?>(dynamic value, [T? defaultValue]) {
  if (value is T) {
    return value;
  }
  try {
    if (value != null) {
      final valueS = value.toString();
      if ('' is T) {
        return valueS as T;
      } else if (0 is T) {
        return int.parse(valueS) as T;
      } else if (0.0 is T) {
        return double.parse(valueS) as T;
      } else if (false is T) {
        if (valueS == '0' || valueS == '1') {
          return (valueS == '1') as T;
        }
        return (valueS == 'true') as T;
      } else {
        return FFConvert.convert<T>(value);
      }
    }
  } catch (e, stackTrace) {
    log('asT<$T>', error: e, stackTrace: stackTrace);
    return defaultValue;
  }

  return defaultValue;
}

void tryCatch(Function? f) {
  try {
    f?.call();
  } catch (e, stack) {
    log('$e');
    log('$stack');
  }
}


// 尝试类型装换 -- 列表类型
List<dynamic> tryCoverList(String result, String paramsKey) {
  if (result.isEmpty) return <dynamic>[];
  try {
    final map = jsonDecode(result);
    if (map[paramsKey] is List<dynamic>) {
      final _arr = map[paramsKey] as List<dynamic>;
      return _arr;
    }
  } catch (e,s) {
    print('解析列表异常:$e');
    print(s);
    return <dynamic>[];
  }

  return <dynamic>[];
}
