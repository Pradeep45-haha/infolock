class OperationFailed implements Exception {
  final String message;
  OperationFailed({required this.message});
}



class FilePickerException implements Exception {
  final String message;
  FilePickerException({required this.message});
}


class NoSuchUserTile implements Exception{
  final String message = "No such user tile";
  NoSuchUserTile();
}