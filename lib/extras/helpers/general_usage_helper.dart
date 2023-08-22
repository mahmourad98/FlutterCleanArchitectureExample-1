extension Nullable on dynamic {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
}