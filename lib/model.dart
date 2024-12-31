class RouterInfo {
  final int? id; // Nullable for new entries
  final String address;
  final String username;
  final String password;
  final int port;

  RouterInfo({
    this.id,
    required this.address,
    required this.username,
    required this.password,
    required this.port,
  });

  // Convert RouterInfo to a Map for SQLite
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'username': username,
      'password': password,
      'port': port,
    };
  }

  // Create a RouterInfo object from a Map
  factory RouterInfo.fromMap(Map<String, dynamic> map) {
    return RouterInfo(
      id: map['id'],
      address: map['address'],
      username: map['username'],
      password: map['password'],
      port: map['port'],
    );
  }
}
