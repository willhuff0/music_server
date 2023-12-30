import 'package:dart_phonetics/dart_phonetics.dart';
import 'package:isar/isar.dart';

final _phoneticsEncoder = DoubleMetaphone();

Set<String> getPhoneticCodesOfWord(String word) {
  final phonetic = _phoneticsEncoder.encode(word)!;
  return {
    phonetic.primary,
    ...?phonetic.alternates,
  };
}

Set<String> getPhoneticCodesOfQuery(String query) => Isar.splitWords(query).expand((word) => getPhoneticCodesOfWord(word)).toSet();
