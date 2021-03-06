import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_adapter_test.mocks.dart';

class HttpAdapter {
  final Client client;

  HttpAdapter(this.client);

  Future<void> request({
    required String url,
    required String method,
    Map? body,
  }) async {
    await client.post(Uri.parse(url));
  }
}

@GenerateMocks([],
    customMocks: [MockSpec<Client>(returnNullOnMissingStub: true)])
void main() {
  group('Post', () {
    test('Shoud call post with correct values', () async {
      final client = MockClient();
      final sut = HttpAdapter(client);
      final url = faker.internet.httpUrl();

      await sut.request(url: url, method: 'post');

      verify(client.post(Uri.parse(url)));
    });
  });
}
