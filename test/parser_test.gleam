import gleeunit
import gleeunit/should
import parser
import parser/token

pub fn main() {
  gleeunit.main()
}

pub fn lex_symbols_test() {
  let expected = [
    token.Assing,
    token.Bang,
    token.LParen,
    token.RParen,
    token.LBrace,
    token.RBrace,
    token.Slash,
    token.Asterisk,
    token.Equal,
    token.Plus,
    token.Minus,
    token.Bang,
    token.Semicolon,
    token.Comma,
    token.EOF
  ]

  "= ! () {} /*==+ -!;,"
  |> parser.lex()
  |> should.equal(expected)
}

pub fn lex_full_expession_test() {
  let expected = [
    token.Let,
    token.Ident(<<"five":utf8>>),
    token.Assing,
    token.Int(<<"5":utf8>>),
    token.Semicolon,
    token.Function,
    token.Ident(<<"x":utf8>>),
    token.LParen,
    token.RParen,
    token.LBrace,
    token.RBrace,
    token.EOF,
  ]

  "let five = 5; fn x(){}"
  |> parser.lex()
  |> should.equal(expected)
}