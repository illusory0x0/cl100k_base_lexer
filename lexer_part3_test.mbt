///|
/// Tests for tokenize_part3: \p{N}{1,3}+
/// This part handles 1 to 3 consecutive number characters (atomic group)
test "tokenize_part3: single digits" {
  @json.inspect(try? tokenize_part3("0"), content=({"Ok":"0"}))
  @json.inspect(try? tokenize_part3("1"), content=({"Ok":"1"}))
  @json.inspect(try? tokenize_part3("5"), content=({"Ok":"5"}))
  @json.inspect(try? tokenize_part3("9"), content=({"Ok":"9"}))
}

///|
test "tokenize_part3: two digits" {
  @json.inspect(try? tokenize_part3("12"), content=({"Ok":"12"}))
  @json.inspect(try? tokenize_part3("42"), content=({"Ok":"42"}))
  @json.inspect(try? tokenize_part3("99"), content=({"Ok":"99"}))
  @json.inspect(try? tokenize_part3("00"), content=({"Ok":"00"}))
  @json.inspect(try? tokenize_part3("07"), content=({"Ok":"07"}))
}

///|
test "tokenize_part3: three digits" {
  @json.inspect(try? tokenize_part3("123"), content=({"Ok":"123"}))
  @json.inspect(try? tokenize_part3("456"), content=({"Ok":"456"}))
  @json.inspect(try? tokenize_part3("999"), content=({"Ok":"999"}))
  @json.inspect(try? tokenize_part3("000"), content=({"Ok":"000"}))
  @json.inspect(try? tokenize_part3("007"), content=({"Ok":"007"}))
}

///|
test "tokenize_part3: maximum three digits with additional content" {
  // Should only consume 3 digits max due to atomic group behavior
  @json.inspect(try? tokenize_part3("1234"), content=({"Ok":"123"}))
  @json.inspect(try? tokenize_part3("4567"), content=({"Ok":"456"}))
  @json.inspect(try? tokenize_part3("9999"), content=({"Ok":"999"}))
  @json.inspect(try? tokenize_part3("0000"), content=({"Ok":"000"}))
  @json.inspect(try? tokenize_part3("12345"), content=({"Ok":"123"}))
  @json.inspect(try? tokenize_part3("123456789"), content=({"Ok":"123"}))
}

///|
test "tokenize_part3: numbers with trailing non-numbers" {
  @json.inspect(try? tokenize_part3("1a"), content=({"Ok":"1"}))
  @json.inspect(try? tokenize_part3("12b"), content=({"Ok":"12"}))
  @json.inspect(try? tokenize_part3("123c"), content=({"Ok":"123"}))
  @json.inspect(try? tokenize_part3("1!"), content=({"Ok":"1"}))
  @json.inspect(try? tokenize_part3("12@"), content=({"Ok":"12"}))
  @json.inspect(try? tokenize_part3("123#"), content=({"Ok":"123"}))
  @json.inspect(try? tokenize_part3("1 "), content=({"Ok":"1"}))
  @json.inspect(try? tokenize_part3("12\t"), content=({"Ok":"12"}))
  @json.inspect(try? tokenize_part3("123\n"), content=({"Ok":"123"}))
}

///|
test "tokenize_part3: unicode digits" {
  // Arabic-Indic digits
  @json.inspect(try? tokenize_part3("١"), content=({"Ok":"١"}))
  @json.inspect(try? tokenize_part3("١٢"), content=({"Ok":"١٢"}))
  @json.inspect(try? tokenize_part3("١٢٣"), content=({"Ok":"١٢٣"}))

  // Tamil digits
  @json.inspect(try? tokenize_part3("௧"), content=({"Ok":"௧"}))
  @json.inspect(try? tokenize_part3("௧௨"), content=({"Ok":"௧௨"}))
  @json.inspect(try? tokenize_part3("௧௨௩"), content=({"Ok":"௧௨௩"}))

  // Thai digits
  @json.inspect(try? tokenize_part3("๑"), content=({"Ok":"๑"}))
  @json.inspect(try? tokenize_part3("๑๒"), content=({"Ok":"๑๒"}))
  @json.inspect(try? tokenize_part3("๑๒๓"), content=({"Ok":"๑๒๓"}))
}

///|
test "tokenize_part3: mixed unicode and ascii digits" {
  @json.inspect(try? tokenize_part3("1٢"), content=({"Ok":"1٢"}))
  @json.inspect(try? tokenize_part3("௧2"), content=({"Ok":"௧2"}))
  @json.inspect(try? tokenize_part3("๑2๓"), content=({"Ok":"๑2๓"}))
  @json.inspect(try? tokenize_part3("1௨3"), content=({"Ok":"1௨3"}))
}

///|
test "tokenize_part3: error cases - no digits" {
  // Empty string
  let result1 = try? tokenize_part3("")
  @json.inspect(result1, content=({"Err":"BackTracing"}))

  // Only letters
  let result2 = try? tokenize_part3("abc")
  @json.inspect(result2, content=({"Err":"BackTracing"}))

  // Only symbols
  let result3 = try? tokenize_part3("!@#")
  @json.inspect(result3, content=({"Err":"BackTracing"}))

  // Only whitespace
  let result4 = try? tokenize_part3("   ")
  @json.inspect(result4, content=({"Err":"BackTracing"}))

  // Starts with non-digit
  let result5 = try? tokenize_part3("a123")
  @json.inspect(result5, content=({"Err":"BackTracing"}))
  let result6 = try? tokenize_part3("!123")
  @json.inspect(result6, content=({"Err":"BackTracing"}))
  let result7 = try? tokenize_part3(" 123")
  @json.inspect(result7, content=({"Err":"BackTracing"}))
}

///|
test "tokenize_part3: error cases - starts with non-numeric unicode" {
  // Chinese numbers (these are not \p{N}, they are letters)
  let result1 = try? tokenize_part3("一二三")
  @json.inspect(result1, content=({"Err":"BackTracing"}))
  let result2 = try? tokenize_part3("零")
  @json.inspect(result2, content=({"Err":"BackTracing"}))

  // Roman numerals (also letters, not numbers)
  let result3 = try? tokenize_part3("VII")
  @json.inspect(result3, content=({"Err":"BackTracing"}))
  let result4 = try? tokenize_part3("III")
  @json.inspect(result4, content=({"Err":"BackTracing"}))
}

///|
test "tokenize_part3: boundary cases - exactly at limits" {
  // Test boundaries of the {1,3} quantifier

  // Minimum: exactly 1 digit
  @json.inspect(try? tokenize_part3("7"), content=({"Ok":"7"}))
  @json.inspect(try? tokenize_part3("0"), content=({"Ok":"0"}))

  // Maximum: exactly 3 digits
  @json.inspect(try? tokenize_part3("789"), content=({"Ok":"789"}))
  @json.inspect(try? tokenize_part3("999"), content=({"Ok":"999"}))

  // Over maximum: 4+ digits (should only take first 3)
  @json.inspect(try? tokenize_part3("7890"), content=({"Ok":"789"}))
  @json.inspect(try? tokenize_part3("12345"), content=({"Ok":"123"}))
}

///|
test "tokenize_part3: edge cases with different number systems" {
  // Full-width digits (these should work as they are \p{N})
  @json.inspect(try? tokenize_part3("１"), content=({"Ok":"１"}))
  @json.inspect(try? tokenize_part3("１２"), content=({"Ok":"１２"}))
  @json.inspect(try? tokenize_part3("１２３"), content=({"Ok":"１２３"}))

  // Superscript digits (if they are classified as \p{N})
  @json.inspect(try? tokenize_part3("¹"), content=({"Ok":"¹"}))
  @json.inspect(try? tokenize_part3("¹²"), content=({"Ok":"¹²"}))
  @json.inspect(try? tokenize_part3("¹²³"), content=({"Ok":"¹²³"}))

  // Subscript digits (if they are classified as \p{N})
  @json.inspect(try? tokenize_part3("₁"), content=({"Ok":"₁"}))
  @json.inspect(try? tokenize_part3("₁₂"), content=({"Ok":"₁₂"}))
  @json.inspect(try? tokenize_part3("₁₂₃"), content=({"Ok":"₁₂₃"}))
}

///|
test "tokenize_part3: mixed with decimal points (should not include decimal)" {
  // Decimal points should not be included, only the integer part
  @json.inspect(try? tokenize_part3("1.5"), content=({"Ok":"1"}))
  @json.inspect(try? tokenize_part3("12.34"), content=({"Ok":"12"}))
  @json.inspect(try? tokenize_part3("123.456"), content=({"Ok":"123"}))
  @json.inspect(try? tokenize_part3("3.14159"), content=({"Ok":"3"}))
  @json.inspect(try? tokenize_part3("42.0"), content=({"Ok":"42"}))
}

///|
test "tokenize_part3: numbers with negative signs (should not include sign)" {
  // Negative signs should not be part of the number pattern
  let result1 = try? tokenize_part3("-123")
  @json.inspect(result1, content=({"Err":"BackTracing"}))
  let result2 = try? tokenize_part3("-1")
  @json.inspect(result2, content=({"Err":"BackTracing"}))
  let result3 = try? tokenize_part3("+123")
  @json.inspect(result3, content=({"Err":"BackTracing"}))
  let result4 = try? tokenize_part3("+1")
  @json.inspect(result4, content=({"Err":"BackTracing"}))
}

///|
test "tokenize_part3: numbers in different contexts" {
  // Standalone numbers
  @json.inspect(try? tokenize_part3("0"), content=({"Ok":"0"}))
  @json.inspect(try? tokenize_part3("42"), content=({"Ok":"42"}))
  @json.inspect(try? tokenize_part3("999"), content=({"Ok":"999"}))

  // Numbers followed by punctuation
  @json.inspect(try? tokenize_part3("42!"), content=({"Ok":"42"}))
  @json.inspect(try? tokenize_part3("123."), content=({"Ok":"123"}))
  @json.inspect(try? tokenize_part3("7,"), content=({"Ok":"7"}))
  @json.inspect(try? tokenize_part3("999;"), content=({"Ok":"999"}))

  // Numbers followed by letters
  @json.inspect(try? tokenize_part3("42px"), content=({"Ok":"42"}))
  @json.inspect(try? tokenize_part3("100%"), content=({"Ok":"100"}))
  @json.inspect(try? tokenize_part3("5th"), content=({"Ok":"5"}))
}
