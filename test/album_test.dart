import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:online_food/album.dart';

import 'album_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  // test("Test with mockito for album json", () {});
  group("fetchAlbum", () {
    test("returns an Album if http call completes successfully", () async {
      final client = MockClient();
      when(client
              .get(Uri.parse("http://jsonplaceholder.typicode.com/albums/1")))
          .thenAnswer((_) async =>
              http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));
      expect(
          await const Album(userId: 1, id: 2, title: 'mock').fetchAlbum(client),
          isA<Album>());
    });
    test("throws an exception if the http call completes with an error", () {
      final client = MockClient();
      when(client
              .get(Uri.parse("http://jsonplaceholder.typicode.com/albums/1")))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(const Album(userId: 1, id: 2, title: 'mock').fetchAlbum(client),
          throwsException);
    });
  });
}
