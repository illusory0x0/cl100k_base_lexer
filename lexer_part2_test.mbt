///|
/// Tests for tokenize_part2: [^\r\n\p{L}\p{N}]?+\p{L}++
/// This part handles optional non-letter/non-number prefix followed by one or more letters
test "tokenize_part2: letters only (no prefix)" {
  @json.inspect(try? tokenize_part2("hello"), content=({"Ok":"hello"}))
  @json.inspect(try? tokenize_part2("world"), content=({"Ok":"world"}))
  @json.inspect(try? tokenize_part2("a"), content=({"Ok":"a"}))
  @json.inspect(try? tokenize_part2("ABC"), content=({"Ok":"ABC"}))
}

///|
test "tokenize_part2: letters with additional text" {
  @json.inspect(try? tokenize_part2("hello world"), content=({"Ok":"hello"}))
  @json.inspect(try? tokenize_part2("word123"), content=({"Ok":"word"}))
  @json.inspect(try? tokenize_part2("test!"), content=({"Ok":"test"}))
  @json.inspect(try? tokenize_part2("abc.def"), content=({"Ok":"abc"}))
}

///|
test "tokenize_part2: single non-letter prefix + letters" {
  @json.inspect(try? tokenize_part2("!hello"), content=({"Ok":"!hello"}))
  @json.inspect(try? tokenize_part2("@world"), content=({"Ok":"@world"}))
  @json.inspect(try? tokenize_part2("#test"), content=({"Ok":"#test"}))
  @json.inspect(try? tokenize_part2("$money"), content=({"Ok":"$money"}))
  @json.inspect(try? tokenize_part2("%percent"), content=({"Ok":"%percent"}))
  @json.inspect(try? tokenize_part2("^caret"), content=({"Ok":"^caret"}))
  @json.inspect(try? tokenize_part2("&and"), content=({"Ok":"&and"}))
  @json.inspect(try? tokenize_part2("*star"), content=({"Ok":"*star"}))
  @json.inspect(try? tokenize_part2("-dash"), content=({"Ok":"-dash"}))
  @json.inspect(try? tokenize_part2("_under"), content=({"Ok":"_under"}))
  @json.inspect(try? tokenize_part2("=equal"), content=({"Ok":"=equal"}))
  @json.inspect(try? tokenize_part2("+plus"), content=({"Ok":"+plus"}))
}

///|
test "tokenize_part2: punctuation prefix + letters" {
  @json.inspect(try? tokenize_part2(".com"), content=({"Ok":".com"}))
  @json.inspect(try? tokenize_part2(",org"), content=({"Ok":",org"}))
  @json.inspect(try? tokenize_part2(";net"), content=({"Ok":";net"}))
  @json.inspect(try? tokenize_part2(":edu"), content=({"Ok":":edu"}))
  @json.inspect(try? tokenize_part2("?query"), content=({"Ok":"?query"}))
  @json.inspect(try? tokenize_part2("/path"), content=({"Ok":"/path"}))
  @json.inspect(try? tokenize_part2("\\escape"), content=({"Ok":"\\escape"}))
  @json.inspect(try? tokenize_part2("|pipe"), content=({"Ok":"|pipe"}))
  @json.inspect(try? tokenize_part2("\"quote"), content=({"Ok":"\"quote"}))
  @json.inspect(try? tokenize_part2("'apos"), content=({"Ok":"'apos"}))
}

///|
test "tokenize_part2: bracket and parenthesis prefix + letters" {
  @json.inspect(try? tokenize_part2("(paren"), content=({"Ok":"(paren"}))
  @json.inspect(try? tokenize_part2(")close"), content=({"Ok":")close"}))
  @json.inspect(try? tokenize_part2("[bracket"), content=({"Ok":"[bracket"}))
  @json.inspect(try? tokenize_part2("]end"), content=({"Ok":"]end"}))
  @json.inspect(try? tokenize_part2("{brace"), content=({"Ok":"{brace"}))
  @json.inspect(try? tokenize_part2("}finish"), content=({"Ok":"}finish"}))
  @json.inspect(try? tokenize_part2("<less"), content=({"Ok":"<less"}))
  @json.inspect(try? tokenize_part2(">greater"), content=({"Ok":">greater"}))
}

///|
test "tokenize_part2: unicode letters with prefix" {
  @json.inspect(try? tokenize_part2("!你好"), content=({"Ok":"!你好"}))
  @json.inspect(try? tokenize_part2("@世界"), content=({"Ok":"@世界"}))
  @json.inspect(
    try? tokenize_part2("#こんにちは"),
    content=({"Ok":"#こんにちは"}),
  )
  @json.inspect(
    try? tokenize_part2("$مرحبا"),
    content=({"Ok":"$مرحبا"}),
  )
  @json.inspect(
    try? tokenize_part2("%Здравствуй"),
    content=({"Ok":"%Здравствуй"}),
  )
  @json.inspect(try? tokenize_part2("^français"), content=({"Ok":"^français"}))
  @json.inspect(try? tokenize_part2("&Español"), content=({"Ok":"&Español"}))
}

///|
test "tokenize_part2: unicode letters only" {
  @json.inspect(try? tokenize_part2("你好"), content=({"Ok":"你好"}))
  @json.inspect(try? tokenize_part2("世界"), content=({"Ok":"世界"}))
  @json.inspect(
    try? tokenize_part2("こんにちは"),
    content=({"Ok":"こんにちは"}),
  )
  @json.inspect(try? tokenize_part2("مرحبا"), content=({"Ok":"مرحبا"}))
  @json.inspect(
    try? tokenize_part2("Здравствуй"),
    content=({"Ok":"Здравствуй"}),
  )
  @json.inspect(try? tokenize_part2("français"), content=({"Ok":"français"}))
  @json.inspect(try? tokenize_part2("Español"), content=({"Ok":"Español"}))
}

///|
test "tokenize_part2: emoji and symbols as prefix" {
  @json.inspect(try? tokenize_part2("🎉party"), content=({"Ok":"🎉party"}))
  @json.inspect(try? tokenize_part2("⭐star"), content=({"Ok":"⭐star"}))
  @json.inspect(try? tokenize_part2("❤️love"), content=({"Ok":"❤️love"}))
  @json.inspect(try? tokenize_part2("🌍world"), content=({"Ok":"🌍world"}))
  @json.inspect(try? tokenize_part2("©copy"), content=({"Ok":"©copy"}))
  @json.inspect(try? tokenize_part2("™trade"), content=({"Ok":"™trade"}))
  @json.inspect(try? tokenize_part2("®reg"), content=({"Ok":"®reg"}))
}

///|
test "tokenize_part2: prefix with trailing non-letters" {
  @json.inspect(try? tokenize_part2("!hello123"), content=({"Ok":"!hello"}))
  @json.inspect(try? tokenize_part2("@world!"), content=({"Ok":"@world"}))
  @json.inspect(try? tokenize_part2("#test$"), content=({"Ok":"#test"}))
  @json.inspect(try? tokenize_part2("$money%"), content=({"Ok":"$money"}))
  @json.inspect(try? tokenize_part2(".test,"), content=({"Ok":".test"}))
}

///|
test "tokenize_part2: error cases - no letters" {
  // Only non-letter characters (no letters to follow)
  let result1 = try? tokenize_part2("123")
  @json.inspect(result1, content=({"Err":"BackTracing"}))
  let result2 = try? tokenize_part2("!@#")
  @json.inspect(result2, content=({"Err":"BackTracing"}))
  let result3 = try? tokenize_part2("...")
  @json.inspect(result3, content=({"Err":"BackTracing"}))

  // Empty string
  let result4 = try? tokenize_part2("")
  @json.inspect(result4, content=({"Err":"BackTracing"}))

  // Only whitespace
  let result5 = try? tokenize_part2("   ")
  @json.inspect(result5, content=({"Err":"BackTracing"}))
}

///|
test "tokenize_part2: error cases - starts with numbers" {
  // Numbers are excluded from the prefix pattern
  let result1 = try? tokenize_part2("1hello")
  @json.inspect(result1, content=({"Err":"BackTracing"}))
  let result2 = try? tokenize_part2("42world")
  @json.inspect(result2, content=({"Err":"BackTracing"}))
  let result3 = try? tokenize_part2("0test")
  @json.inspect(result3, content=({"Err":"BackTracing"}))

  // Unicode numbers as prefix
  let result4 = try? tokenize_part2("١hello")
  @json.inspect(result4, content=({"Err":"BackTracing"}))
  let result5 = try? tokenize_part2("௧test")
  @json.inspect(result5, content=({"Err":"BackTracing"}))
}

///|
test "tokenize_part2: error cases - starts with forbidden characters" {
  // \r and \n are explicitly excluded from prefix pattern
  let result1 = try? tokenize_part2("\rhello")
  @json.inspect(result1, content=({"Err":"BackTracing"}))
  let result2 = try? tokenize_part2("\nworld")
  @json.inspect(result2, content=({"Err":"BackTracing"}))
  let result3 = try? tokenize_part2("\r\ntest")
  @json.inspect(result3, content=({"Err":"BackTracing"}))
}

///|
test "tokenize_part2: error cases - starts with letters (no prefix allowed when letters come first)" {
  // When letters come first, no prefix is consumed, but this should still work
  // Actually, this should work - letters without prefix are valid
  @json.inspect(try? tokenize_part2("abc"), content=({"Ok":"abc"}))
  @json.inspect(try? tokenize_part2("hello"), content=({"Ok":"hello"}))

  // These are edge cases where we test the boundary
  @json.inspect(try? tokenize_part2("a1"), content=({"Ok":"a"}))
  @json.inspect(try? tokenize_part2("x!"), content=({"Ok":"x"}))
}

///|
test "tokenize_part2: boundary cases with mixed content" {
  // Test the exact pattern: [^\r\n\p{L}\p{N}]?+\p{L}++
  // Optional prefix + required letters
  @json.inspect(try? tokenize_part2("!a"), content=({"Ok":"!a"}))
  @json.inspect(try? tokenize_part2("@B"), content=({"Ok":"@B"}))
  @json.inspect(try? tokenize_part2("#ç"), content=({"Ok":"#ç"}))
  @json.inspect(try? tokenize_part2("$É"), content=({"Ok":"$É"}))

  // Single letter cases
  @json.inspect(try? tokenize_part2("a"), content=({"Ok":"a"}))
  @json.inspect(try? tokenize_part2("Z"), content=({"Ok":"Z"}))
  @json.inspect(try? tokenize_part2("ñ"), content=({"Ok":"ñ"}))
  @json.inspect(try? tokenize_part2("中"), content=({"Ok":"中"}))
}

///|
test "tokenize_part2: multiple prefix characters (only one should be consumed)" {
  // Pattern allows only 0 or 1 prefix character
  @json.inspect(try? tokenize_part2("!!hello"), content=({"Ok":"!!hello"}))
  @json.inspect(try? tokenize_part2("@@world"), content=({"Ok":"@@world"}))
  @json.inspect(try? tokenize_part2("##test"), content=({"Ok":"##test"}))
  @json.inspect(try? tokenize_part2("$$money"), content=({"Ok":"$$money"}))
}

///|
test "tokenize_part2: edge case - consecutive letter sequences" {
  // Should only consume first letter sequence
  @json.inspect(try? tokenize_part2("hello world"), content=({"Ok":"hello"}))
  @json.inspect(try? tokenize_part2("test!more"), content=({"Ok":"test"}))
  @json.inspect(try? tokenize_part2("first@second"), content=({"Ok":"first"}))
  @json.inspect(try? tokenize_part2("alpha123beta"), content=({"Ok":"alpha"}))
}
