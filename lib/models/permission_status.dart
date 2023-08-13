
class PermissionStatus {

  final int status;

  PermissionStatus({
    required this.status
  });

  bool get isGranted => status == 0;
  bool get isDenied => status == 1;
  bool get isPermanentlyDenied => status == 2;

  factory PermissionStatus.fromJson(Map<String, dynamic> json) {
    return PermissionStatus(status: json["status"]);
  }

  @override
  String toString() {
    String status = "Unknown";
    switch (this.status) {
      case 0:
        status = "Granted";
        break;
      case 1:
        status = "Denied";
        break;
      case 2:
        status = "PermanentlyDenied";
        break;
    }
    return "PermissionStatus(status: $status)";
  }
}