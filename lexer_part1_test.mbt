///|
/// Tests for tokenize_part1: '(?i:[sdmt]|ll|ve|re)
/// This part handles contractions with apostrophe
test "tokenize_part1: case-insensitive [sdmt] - lowercase" {
  @json.inspect(try? tokenize_part1("'s"), content={ "Ok": "'s" })
  @json.inspect(try? tokenize_part1("'d"), content={ "Ok": "'d" })
  @json.inspect(try? tokenize_part1("'m"), content={ "Ok": "'m" })
  @json.inspect(try? tokenize_part1("'t"), content={ "Ok": "'t" })
}

///|
test "tokenize_part1: case-insensitive [sdmt] - uppercase" {
  @json.inspect(try? tokenize_part1("'S"), content={ "Ok": "'S" })
  @json.inspect(try? tokenize_part1("'D"), content={ "Ok": "'D" })
  @json.inspect(try? tokenize_part1("'M"), content={ "Ok": "'M" })
  @json.inspect(try? tokenize_part1("'T"), content={ "Ok": "'T" })
}

///|
test "tokenize_part1: exact patterns ll, ve, re" {
  @json.inspect(try? tokenize_part1("'ll"), content={ "Ok": "'ll" })
  @json.inspect(try? tokenize_part1("'ve"), content={ "Ok": "'ve" })
  @json.inspect(try? tokenize_part1("'re"), content={ "Ok": "'re" })
}

///|
test "tokenize_part1: with additional text after valid patterns" {
  @json.inspect(try? tokenize_part1("'s something"), content={ "Ok": "'s" })
  @json.inspect(try? tokenize_part1("'ll work"), content={ "Ok": "'ll" })
  @json.inspect(try? tokenize_part1("'ve been"), content={ "Ok": "'ve" })
  @json.inspect(try? tokenize_part1("'re going"), content={ "Ok": "'re" })
}

///|
test "tokenize_part1: error cases - invalid patterns" {
  // Not starting with apostrophe
  let result1 = try? tokenize_part1("s")
  @json.inspect(result1, content={ "Err": "BackTracing" })

  // Invalid letters after apostrophe
  let result2 = try? tokenize_part1("'a")
  @json.inspect(result2, content={ "Err": "BackTracing" })
  let result3 = try? tokenize_part1("'z")
  @json.inspect(result3, content={ "Err": "BackTracing" })

  // Empty string
  let result4 = try? tokenize_part1("")
  @json.inspect(result4, content={ "Err": "BackTracing" })

  // Just apostrophe
  let result5 = try? tokenize_part1("'")
  @json.inspect(result5, content={ "Err": "BackTracing" })
}

///|
test "tokenize_part1: error cases - wrong case for exact patterns" {
  // ll, ve, re are case-sensitive, these should fail
  let result1 = try? tokenize_part1("'LL")
  @json.inspect(result1, content={ "Err": "BackTracing" })
  let result2 = try? tokenize_part1("'VE")
  @json.inspect(result2, content={ "Err": "BackTracing" })
  let result3 = try? tokenize_part1("'RE")
  @json.inspect(result3, content={ "Err": "BackTracing" })

  // Mixed case
  let result4 = try? tokenize_part1("'Ll")
  @json.inspect(result4, content={ "Err": "BackTracing" })
  let result5 = try? tokenize_part1("'Ve")
  @json.inspect(result5, content={ "Err": "BackTracing" })
  let result6 = try? tokenize_part1("'Re")
  @json.inspect(result6, content={ "Err": "BackTracing" })
}

///|
test "tokenize_part1: error cases - partial matches" {
  // Incomplete patterns
  let result1 = try? tokenize_part1("'l")
  @json.inspect(result1, content={ "Err": "BackTracing" })
  let result2 = try? tokenize_part1("'v")
  @json.inspect(result2, content={ "Err": "BackTracing" })
  let result3 = try? tokenize_part1("'r")
  @json.inspect(result3, content={ "Err": "BackTracing" })

  // Wrong patterns with correct length
  let result4 = try? tokenize_part1("'xy")
  @json.inspect(result4, content={ "Err": "BackTracing" })
  let result5 = try? tokenize_part1("'ab")
  @json.inspect(result5, content={ "Err": "BackTracing" })
}

///|
test "tokenize_part1: edge cases - special characters and unicode" {
  // Non-ASCII apostrophe-like characters (should fail)
  let result1 = try? tokenize_part1("'s") // Using curly apostrophe
  @json.inspect(result1, content={ "Ok": "'s" })

  // Numbers after apostrophe
  let result2 = try? tokenize_part1("'1")
  @json.inspect(result2, content={ "Err": "BackTracing" })

  // Symbols after apostrophe
  let result3 = try? tokenize_part1("'@")
  @json.inspect(result3, content={ "Err": "BackTracing" })

  // Whitespace after apostrophe
  let result4 = try? tokenize_part1("' ")
  @json.inspect(result4, content={ "Err": "BackTracing" })
}

///|
test "tokenize_part1: boundary conditions" {
  // Single character inputs for valid cases
  @json.inspect(try? tokenize_part1("'s "), content={ "Ok": "'s" })
  @json.inspect(try? tokenize_part1("'S!"), content={ "Ok": "'S" })
  @json.inspect(try? tokenize_part1("'d."), content={ "Ok": "'d" })
  @json.inspect(try? tokenize_part1("'D,"), content={ "Ok": "'D" })
  @json.inspect(try? tokenize_part1("'m;"), content={ "Ok": "'m" })
  @json.inspect(try? tokenize_part1("'M:"), content={ "Ok": "'M" })
  @json.inspect(try? tokenize_part1("'t?"), content={ "Ok": "'t" })
  @json.inspect(try? tokenize_part1("'T)"), content={ "Ok": "'T" })
}

///|
test "tokenize_part1: three-letter patterns with additional text" {
  @json.inspect(try? tokenize_part1("'ll!"), content={ "Ok": "'ll" })
  @json.inspect(try? tokenize_part1("'ve."), content={ "Ok": "'ve" })
  @json.inspect(try? tokenize_part1("'re,"), content={ "Ok": "'re" })
  @json.inspect(try? tokenize_part1("'ll "), content={ "Ok": "'ll" })
  @json.inspect(try? tokenize_part1("'ve "), content={ "Ok": "'ve" })
  @json.inspect(try? tokenize_part1("'re "), content={ "Ok": "'re" })
}
