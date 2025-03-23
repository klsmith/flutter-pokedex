/// A list of paginated data from PokeAPI.
class ApiResourceList {
  int count;
  String? next;
  String? previous;
  List<ApiResource> results;

  ApiResourceList(this.count, this.next, this.previous, this.results);

  factory ApiResourceList.empty() {
    return ApiResourceList(0, null, null, []);
  }

  factory ApiResourceList.fromJson(Map json) {
    var results = json['results'] as List;
    return ApiResourceList(
      json['count'] as int,
      json['next'] as String?,
      json['previous'] as String?,
      results.map((j) => ApiResource.fromJson(j)).toList(),
    );
  }

  @override
  String toString() {
    return 'ApiResourceList( count=$count, next=$next, previous=$previous, results=$results )';
  }
}

/// A single instance of paginated data from PokeAPI.
class ApiResource {
  String? name;
  String url;

  ApiResource(this.url, this.name);

  factory ApiResource.fromJson(Map json) {
    var name = json['name'] as String?;
    var url = json['url'] as String;
    return ApiResource(url, name);
  }

  @override
  String toString() {
    return 'ApiResource( name=$name, url=$url )';
  }
}
