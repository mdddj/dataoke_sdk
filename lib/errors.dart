

class AppError implements Error {
  final String errorText;
  AppError(this.errorText);

  @override
  StackTrace? get stackTrace => null;



}