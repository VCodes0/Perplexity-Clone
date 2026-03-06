/// Dart models matching the FastAPI backend schemas.

class SourceItem {
  final String title;
  final String url;
  final String snippet;

  const SourceItem({
    required this.title,
    required this.url,
    required this.snippet,
  });

  factory SourceItem.fromJson(Map<String, dynamic> json) => SourceItem(
        title: json['title'] as String? ?? '',
        url: json['url'] as String? ?? '',
        snippet: json['snippet'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'url': url,
        'snippet': snippet,
      };
}

class SearchRequest {
  final String query;
  final String searchMode;

  const SearchRequest({required this.query, this.searchMode = 'auto'});

  Map<String, dynamic> toJson() => {
        'query': query,
        'search_mode': searchMode,
      };
}

class SearchResponse {
  final String query;
  final String answer;
  final List<SourceItem> sources;
  final String searchMode;
  final String modelUsed;

  const SearchResponse({
    required this.query,
    required this.answer,
    required this.sources,
    required this.searchMode,
    required this.modelUsed,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        query: json['query'] as String? ?? '',
        answer: json['answer'] as String? ?? '',
        sources: (json['sources'] as List<dynamic>? ?? [])
            .map((e) => SourceItem.fromJson(e as Map<String, dynamic>))
            .toList(),
        searchMode: json['search_mode'] as String? ?? 'auto',
        modelUsed: json['model_used'] as String? ?? '',
      );
}
