import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flutter_tdd/data/http/http.dart';
import 'package:flutter_tdd/data/usecases/usecases.dart';
import 'package:flutter_tdd/domain/usecases/usecases.dart';

import 'remote_authetication_test.mocks.dart';

@GenerateMocks([HttpClient])
void main() {
  late RemoteAuthentication sut;
  late MockHttpClient httpClient;
  late String url;

  setUp(() {
    httpClient = MockHttpClient();
    url = faker.internet.httpUrl();
    sut = RemoteAuthentication(httpClient: httpClient, url: url);
  });

  test("Should call Httpclient with correct body", () async {
    final params = AuthenticationParams(
      email: faker.internet.email(),
      secret: faker.internet.password(),
    );
    await sut.auth(params);

    verify(
      httpClient.request(
        url: url,
        method: 'post',
        body: {
          'email': params.email,
          'password': params.secret,
        },
      ),
    );
  });
}