// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_response_model.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializers _$_serializers =
    (new Serializers().toBuilder()..add(CommonResponse.serializer)).build();
Serializer<CommonResponse> _$commonResponseSerializer =
    new _$CommonResponseSerializer();

class _$CommonResponseSerializer
    implements StructuredSerializer<CommonResponse> {
  @override
  final Iterable<Type> types = const [CommonResponse, _$CommonResponse];
  @override
  final String wireName = 'CommonResponse';

  @override
  Iterable<Object?> serialize(Serializers serializers, CommonResponse object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.data;
    if (value != null) {
      result
        ..add('data')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(JsonObject)));
    }
    value = object.errors;
    if (value != null) {
      result
        ..add('errors')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(JsonObject)));
    }
    return result;
  }

  @override
  CommonResponse deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CommonResponseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'data':
          result.data = serializers.deserialize(value,
              specifiedType: const FullType(JsonObject)) as JsonObject?;
          break;
        case 'errors':
          result.errors = serializers.deserialize(value,
              specifiedType: const FullType(JsonObject)) as JsonObject?;
          break;
      }
    }

    return result.build();
  }
}

class _$CommonResponse extends CommonResponse {
  @override
  final bool? status;
  @override
  final String? message;
  @override
  final JsonObject? data;
  @override
  final JsonObject? errors;

  factory _$CommonResponse([void Function(CommonResponseBuilder)? updates]) =>
      (new CommonResponseBuilder()..update(updates))._build();

  _$CommonResponse._({this.status, this.message, this.data, this.errors})
      : super._();

  @override
  CommonResponse rebuild(void Function(CommonResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CommonResponseBuilder toBuilder() =>
      new CommonResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CommonResponse &&
        status == other.status &&
        message == other.message &&
        data == other.data &&
        errors == other.errors;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, data.hashCode);
    _$hash = $jc(_$hash, errors.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CommonResponse')
          ..add('status', status)
          ..add('message', message)
          ..add('data', data)
          ..add('errors', errors))
        .toString();
  }
}

class CommonResponseBuilder
    implements Builder<CommonResponse, CommonResponseBuilder> {
  _$CommonResponse? _$v;

  bool? _status;
  bool? get status => _$this._status;
  set status(bool? status) => _$this._status = status;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  JsonObject? _data;
  JsonObject? get data => _$this._data;
  set data(JsonObject? data) => _$this._data = data;

  JsonObject? _errors;
  JsonObject? get errors => _$this._errors;
  set errors(JsonObject? errors) => _$this._errors = errors;

  CommonResponseBuilder();

  CommonResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _message = $v.message;
      _data = $v.data;
      _errors = $v.errors;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CommonResponse other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$CommonResponse;
  }

  @override
  void update(void Function(CommonResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CommonResponse build() => _build();

  _$CommonResponse _build() {
    final _$result = _$v ??
        new _$CommonResponse._(
            status: status, message: message, data: data, errors: errors);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
