import 'dart:convert';

class QueuedRequest {
  final String id;
  final String url;
  final String method;

  final Map<String, dynamic>? body;

  final Map<String, dynamic>? headers;

  final DateTime createdAt;

  final int retryCount;

  QueuedRequest({
    required this.id,
    required this.url,
    required this.method,
    this.body,
    this.headers,
    required this.createdAt,
    this.retryCount = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'method': method,
      'body': body,
      'headers': headers,
      'createdAt': createdAt.toIso8601String(),
      'retryCount': retryCount,
    };
  }

  factory QueuedRequest.fromMap(
    Map<String, dynamic> map,
  ) {
    return QueuedRequest(
      id: map['id'],
      url: map['url'],
      method: map['method'],
      body: map['body'],
      headers: map['headers'],
      createdAt: DateTime.parse(
        map['createdAt'],
      ),
      retryCount: map['retryCount'] ?? 0,
    );
  }

  String toJson() {
    return jsonEncode(toMap());
  }

  factory QueuedRequest.fromJson(
    String source,
  ) {
    return QueuedRequest.fromMap(
      jsonDecode(source),
    );
  }
}