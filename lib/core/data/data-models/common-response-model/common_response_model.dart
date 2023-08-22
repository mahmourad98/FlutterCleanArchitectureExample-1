import 'package:built_value/built_value.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
// ignore: implementation_imports
import 'package:built_value/src/json_object_serializer.dart';
// ignore: depend_on_referenced_packages
import 'package:built_value/standard_json_plugin.dart';

part 'common_response_model.g.dart';

abstract class CommonResponse implements Built<CommonResponse, CommonResponseBuilder> {
  CommonResponse._();
  factory CommonResponse([void Function(CommonResponseBuilder b,) updates,]) = _$CommonResponse;


  @BuiltValueField(wireName: 'status',)
  bool? get status;

  @BuiltValueField(wireName: 'message',)
  String? get message;

  @BuiltValueField(wireName: 'data',)
  JsonObject? get data;

  @BuiltValueField(wireName: 'errors',)
  JsonObject? get errors;

  static Object toJson(CommonResponse instance,) {
    return _serializers.serializeWith<CommonResponse>(CommonResponse.serializer, instance,)!;
  }

  static CommonResponse fromJson(Object json,) {
    return _serializers.deserializeWith<CommonResponse>(CommonResponse.serializer, json,)!;
  }

  static Serializer<CommonResponse> get serializer => _$commonResponseSerializer;
}

@SerializersFor([CommonResponse,])
final Serializers _serializers = (_$_serializers.toBuilder()..addPlugin(StandardJsonPlugin(),)..add(JsonObjectSerializer(),)).build();

