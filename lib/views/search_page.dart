import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ordinary/model/Characters.dart';
import 'package:ordinary/service/api_service.dart';
import 'package:ordinary/utilities/app_color.dart';
import 'package:ordinary/utilities/widgets/app_bar.dart';
import 'package:ordinary/utilities/widgets/bottombar.dart';
import 'package:ordinary/utilities/widgets/char_card.dart';
import 'char_details.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  static String route = 'SearchPage';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  List<Result> _results = [];
  bool _isLoading = false;
  bool _hasNextPage = false;
  int _currentPage = 1;
  String _query = "";

  late GraphQLClient _client;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _client = GraphQLProvider.of(context).value;
  }

  Future<void> _searchCharacters({bool reset = false}) async {
    if (_query.isEmpty || _isLoading) return;

    if (reset) {
      _results.clear();
      _currentPage = 1;
      _hasNextPage = true;
    }

    setState(() => _isLoading = true);

    try {
      final result = await _client.query(
        QueryOptions(
          document: gql(ApiService.getCharacters),
          variables: {"name": _query, "page": _currentPage},
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException || result.data == null) {
        print("Search Error: ${result.exception}");
        setState(() => _isLoading = false);
        return;
      }

      final data = result.data?['characters'];
      final characters = CharactersModel.fromJson({"characters": data});
      final fetched = characters.characters?.results ?? [];

      setState(() {
        _results.addAll(fetched);
        _hasNextPage = data['info']?['next'] != null;
        if (_hasNextPage) _currentPage++;
      });
    } catch (e) {
      print("Error searching: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: const CustomAppBar(),
      bottomNavigationBar: BottomBar(currentIndex: 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              TextField(
                controller: _controller,
                onChanged: (value) {
                  setState(() => _query = value.trim());
                  if (value.isNotEmpty) _searchCharacters(reset: true);
                },
                decoration: InputDecoration(
                  hintText: 'Search characters...',
                  prefixIcon: Icon(Icons.search, color: AppColors.fadedcolor),
                  filled: true,
                  fillColor: AppColors.purewhite,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                    BorderSide(color: AppColors.primarybutton, width: 1.5),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: _query.isEmpty
                    ? const Center(
                  child: Text('Type something to search...'),
                )
                    : _isLoading && _results.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : _results.isEmpty
                    ? const Center(child: Text('No results found'))
                    : _buildGridView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.75,
            ),
            itemCount: _results.length,
            itemBuilder: (context, index) {
              final character = _results[index];
              return Container(
                decoration: BoxDecoration(
                  color: AppColors.purewhite,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    context.pushNamed(
                      CharacterDetailScreen.route,
                      queryParameters: {'id': character.id.toString()},
                    );
                  },
                  child: CharCard(character: character),
                ),
              );
            },
          ),
          const SizedBox(height: 20),

          if (_isLoading)
            const CircularProgressIndicator()
          else if (_hasNextPage)
            ElevatedButton(
              onPressed: () => _searchCharacters(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primarybutton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              ),
              child:Text(
                'View More',
                style: TextStyle(color: AppColors.purewhite, fontSize: 13),
              ),
            )
          else
            const Padding(
              padding: EdgeInsets.all(8),
              child: Text('No more results'),
            ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
