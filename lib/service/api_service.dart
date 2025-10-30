class ApiService {
  static String baseurl = 'https://rickandmortyapi.com';
  static String path = '$baseurl/graphql';
  static Map<String, String> header = {'Content-Type': 'application/json'};

  static String getCharacters = r'''
    query GetCharacters($page: Int, $name: String) {
      characters(page: $page, filter: { name: $name }) {
        info {
          count
          next
          prev
          pages
        }
        results {
          id
          name
          gender
          species
          status
          image
        }
      }
    }
  ''';

  static String getCharacterById = """
    query GetCharacterById(\$id: ID!) {
      character(id: \$id) {
        id
        name
        image
        gender
        status
        species 
        origin {
          name
        }
        episode {
          name
          id
          air_date
          characters {
            id
            name
            status
            image
            type
            gender
          }
        }
        location {
          name
        }
      }
    }
  """;
}
