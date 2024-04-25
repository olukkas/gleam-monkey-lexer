import gleam/list
import gleeunit/should
import parser/token

// gleeunit test functions end in `_test`
pub fn keyword_test() {
  let expected = [
    token.If,
		token.Else,
		token.True,
		token.False,
		token.Function,
		token.Let,
		token.Ident("five")
  ]

  ["if", "else", "true", "false", "fn", "let", "five"]
  |> list.map(with: token.keyword)
  |> should.equal(expected)
}
