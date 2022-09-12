import 'dart:convert';

class Project {
  String? title;
  String? url;
  String? desc;
  Project({
    this.title,
    this.url,
    this.desc,
  });

  Project copyWith({
    String? title,
    String? url,
    String? desc,
  }) {
    return Project(
      title: title ?? this.title,
      url: url ?? this.url,
      desc: desc ?? this.desc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'url': url,
      'desc': desc,
    };
  }

  factory Project.fromMap(Map<String, dynamic> map) {
    return Project(
      title: map['title'],
      url: map['url'],
      desc: map['desc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Project.fromJson(String source) =>
      Project.fromMap(json.decode(source));

  @override
  String toString() => 'Project(title: $title, url: $url, desc: $desc)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Project &&
        other.title == title &&
        other.url == url &&
        other.desc == desc;
  }

  @override
  int get hashCode => title.hashCode ^ url.hashCode ^ desc.hashCode;
}
