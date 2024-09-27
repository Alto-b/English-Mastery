class Writing1CheckGrammarModel {
  Writing1CheckGrammarModel({
    required this.correctedText,
    required this.bandScore,
    required this.grammarResult,
  });

  final String? correctedText;
  final double? bandScore;
  final GrammarResult? grammarResult;

  factory Writing1CheckGrammarModel.fromJson(Map<String, dynamic> json) {
    return Writing1CheckGrammarModel(
      correctedText: json["corrected_text"],
      bandScore: json["band_score"],
      grammarResult: json["grammar_result"] == null
          ? null
          : GrammarResult.fromJson(json["grammar_result"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "corrected_text": correctedText,
        "band_score": bandScore,
        "grammar_result": grammarResult?.toJson(),
      };
}

class GrammarResult {
  GrammarResult({
    required this.software,
    required this.warnings,
    required this.language,
    required this.matches,
    required this.sentenceRanges,
    required this.extendedSentenceRanges,
  });

  final Software? software;
  final Warnings? warnings;
  final Language? language;
  final List<Match> matches;
  final List<List<int>> sentenceRanges;
  final List<ExtendedSentenceRange> extendedSentenceRanges;

  factory GrammarResult.fromJson(Map<String, dynamic> json) {
    return GrammarResult(
      software:
          json["software"] == null ? null : Software.fromJson(json["software"]),
      warnings:
          json["warnings"] == null ? null : Warnings.fromJson(json["warnings"]),
      language:
          json["language"] == null ? null : Language.fromJson(json["language"]),
      matches: json["matches"] == null
          ? []
          : List<Match>.from(json["matches"]!.map((x) => Match.fromJson(x))),
      sentenceRanges: json["sentenceRanges"] == null
          ? []
          : List<List<int>>.from(json["sentenceRanges"]!
              .map((x) => x == null ? [] : List<int>.from(x!.map((x) => x)))),
      extendedSentenceRanges: json["extendedSentenceRanges"] == null
          ? []
          : List<ExtendedSentenceRange>.from(json["extendedSentenceRanges"]!
              .map((x) => ExtendedSentenceRange.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "software": software?.toJson(),
        "warnings": warnings?.toJson(),
        "language": language?.toJson(),
        "matches": matches.map((x) => x?.toJson()).toList(),
        "sentenceRanges":
            sentenceRanges.map((x) => x.map((x) => x).toList()).toList(),
        "extendedSentenceRanges":
            extendedSentenceRanges.map((x) => x?.toJson()).toList(),
      };
}

class ExtendedSentenceRange {
  ExtendedSentenceRange({
    required this.from,
    required this.to,
    required this.detectedLanguages,
  });

  final int? from;
  final int? to;
  final List<DetectedLanguageElement> detectedLanguages;

  factory ExtendedSentenceRange.fromJson(Map<String, dynamic> json) {
    return ExtendedSentenceRange(
      from: json["from"],
      to: json["to"],
      detectedLanguages: json["detectedLanguages"] == null
          ? []
          : List<DetectedLanguageElement>.from(json["detectedLanguages"]!
              .map((x) => DetectedLanguageElement.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "detectedLanguages": detectedLanguages.map((x) => x?.toJson()).toList(),
      };
}

class DetectedLanguageElement {
  DetectedLanguageElement({
    required this.language,
    required this.rate,
  });

  final String? language;
  final double? rate;

  factory DetectedLanguageElement.fromJson(Map<String, dynamic> json) {
    return DetectedLanguageElement(
      language: json["language"],
      rate: json["rate"],
    );
  }

  Map<String, dynamic> toJson() => {
        "language": language,
        "rate": rate,
      };
}

class Language {
  Language({
    required this.name,
    required this.code,
    required this.detectedLanguage,
  });

  final String? name;
  final String? code;
  final LanguageDetectedLanguage? detectedLanguage;

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      name: json["name"],
      code: json["code"],
      detectedLanguage: json["detectedLanguage"] == null
          ? null
          : LanguageDetectedLanguage.fromJson(json["detectedLanguage"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "detectedLanguage": detectedLanguage?.toJson(),
      };
}

class LanguageDetectedLanguage {
  LanguageDetectedLanguage({
    required this.name,
    required this.code,
    required this.confidence,
    required this.source,
  });

  final String? name;
  final String? code;
  final double? confidence;
  final String? source;

  factory LanguageDetectedLanguage.fromJson(Map<String, dynamic> json) {
    return LanguageDetectedLanguage(
      name: json["name"],
      code: json["code"],
      confidence: json["confidence"],
      source: json["source"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "code": code,
        "confidence": confidence,
        "source": source,
      };
}

class Match {
  Match({
    required this.message,
    required this.shortMessage,
    required this.replacements,
    required this.offset,
    required this.length,
    required this.context,
    required this.sentence,
    required this.type,
    required this.rule,
    required this.ignoreForIncompleteSentence,
    required this.contextForSureMatch,
  });

  final String? message;
  final String? shortMessage;
  final List<Replacement> replacements;
  final int? offset;
  final int? length;
  final Context? context;
  final String? sentence;
  final Type? type;
  final Rule? rule;
  final bool? ignoreForIncompleteSentence;
  final int? contextForSureMatch;

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      message: json["message"],
      shortMessage: json["shortMessage"],
      replacements: json["replacements"] == null
          ? []
          : List<Replacement>.from(
              json["replacements"]!.map((x) => Replacement.fromJson(x))),
      offset: json["offset"],
      length: json["length"],
      context:
          json["context"] == null ? null : Context.fromJson(json["context"]),
      sentence: json["sentence"],
      type: json["type"] == null ? null : Type.fromJson(json["type"]),
      rule: json["rule"] == null ? null : Rule.fromJson(json["rule"]),
      ignoreForIncompleteSentence: json["ignoreForIncompleteSentence"],
      contextForSureMatch: json["contextForSureMatch"],
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "shortMessage": shortMessage,
        "replacements": replacements.map((x) => x?.toJson()).toList(),
        "offset": offset,
        "length": length,
        "context": context?.toJson(),
        "sentence": sentence,
        "type": type?.toJson(),
        "rule": rule?.toJson(),
        "ignoreForIncompleteSentence": ignoreForIncompleteSentence,
        "contextForSureMatch": contextForSureMatch,
      };
}

class Context {
  Context({
    required this.text,
    required this.offset,
    required this.length,
  });

  final String? text;
  final int? offset;
  final int? length;

  factory Context.fromJson(Map<String, dynamic> json) {
    return Context(
      text: json["text"],
      offset: json["offset"],
      length: json["length"],
    );
  }

  Map<String, dynamic> toJson() => {
        "text": text,
        "offset": offset,
        "length": length,
      };
}

class Replacement {
  Replacement({
    required this.value,
  });

  final String? value;

  factory Replacement.fromJson(Map<String, dynamic> json) {
    return Replacement(
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}

class Rule {
  Rule({
    required this.id,
    required this.description,
    required this.issueType,
    required this.category,
    required this.isPremium,
    required this.confidence,
    required this.subId,
    required this.sourceFile,
    required this.urls,
  });

  final String? id;
  final String? description;
  final String? issueType;
  final Category? category;
  final bool? isPremium;
  final double? confidence;
  final String? subId;
  final String? sourceFile;
  final List<Replacement> urls;

  factory Rule.fromJson(Map<String, dynamic> json) {
    return Rule(
      id: json["id"],
      description: json["description"],
      issueType: json["issueType"],
      category:
          json["category"] == null ? null : Category.fromJson(json["category"]),
      isPremium: json["isPremium"],
      confidence: json["confidence"],
      subId: json["subId"],
      sourceFile: json["sourceFile"],
      urls: json["urls"] == null
          ? []
          : List<Replacement>.from(
              json["urls"]!.map((x) => Replacement.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "issueType": issueType,
        "category": category?.toJson(),
        "isPremium": isPremium,
        "confidence": confidence,
        "subId": subId,
        "sourceFile": sourceFile,
        "urls": urls.map((x) => x?.toJson()).toList(),
      };
}

class Category {
  Category({
    required this.id,
    required this.name,
  });

  final String? id;
  final String? name;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name: json["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Type {
  Type({
    required this.typeName,
  });

  final String? typeName;

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      typeName: json["typeName"],
    );
  }

  Map<String, dynamic> toJson() => {
        "typeName": typeName,
      };
}

class Software {
  Software({
    required this.name,
    required this.version,
    required this.buildDate,
    required this.apiVersion,
    required this.premium,
    required this.premiumHint,
    required this.status,
  });

  final String? name;
  final String? version;
  final String? buildDate;
  final int? apiVersion;
  final bool? premium;
  final String? premiumHint;
  final String? status;

  factory Software.fromJson(Map<String, dynamic> json) {
    return Software(
      name: json["name"],
      version: json["version"],
      buildDate: json["buildDate"],
      apiVersion: json["apiVersion"],
      premium: json["premium"],
      premiumHint: json["premiumHint"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "version": version,
        "buildDate": buildDate,
        "apiVersion": apiVersion,
        "premium": premium,
        "premiumHint": premiumHint,
        "status": status,
      };
}

class Warnings {
  Warnings({
    required this.incompleteResults,
  });

  final bool? incompleteResults;

  factory Warnings.fromJson(Map<String, dynamic> json) {
    return Warnings(
      incompleteResults: json["incompleteResults"],
    );
  }

  Map<String, dynamic> toJson() => {
        "incompleteResults": incompleteResults,
      };
}
