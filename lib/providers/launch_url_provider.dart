import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:test_task/exception/launch_stream_exception.dart';
import 'package:url_launcher/url_launcher.dart';

//
final launchStreamProvider = StreamProvider((ref) => launchStream());

Stream<AsyncValue<void>> launchStream() async* {
  await for (final value in sampleStream) {
    if (value.value == null || value.value == '') {
      yield const AsyncValue.data(null);
    } else {
      var result = await launchUrl(
        Uri.parse(
          value.value!,
        ),
      );

      if (result) {
        yield AsyncData(result);
      } else {
        throw LaunchUrlException();
      }
    }
  }
}

late final Stream<AsyncValue<String>> sampleStream = Stream.value(null).map((_) {
  return const AsyncValue.data('https://google.com');
});
