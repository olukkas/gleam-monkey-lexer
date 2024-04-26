import gleam/io
import parser/token

pub fn main() {
  io.println("Hello from parser!")
}

pub fn tokenize(input: BitArray) -> #(token.Token, BitArray) {
  case input {
    <<"==":utf8, rest:bits>> -> #(token.Equal, rest)
    <<"!=":utf8, rest:bits>> -> #(token.NotEquals, rest)
    <<"=":utf8, rest:bits>> -> #(token.Assing, rest)
    <<"!":utf8, rest:bits>> -> #(token.Bang, rest)
    <<"+":utf8, rest:bits>> -> #(token.Plus, rest)
    <<"-":utf8, rest:bits>> -> #(token.Minus, rest)
    <<"*":utf8, rest:bits>> -> #(token.Asterisk, rest)
    <<"/":utf8, rest:bits>> -> #(token.Slash, rest)
    <<"<":utf8, rest:bits>> -> #(token.LessThan, rest)
    <<">":utf8, rest:bits>> -> #(token.GreaterThan, rest)
    <<";":utf8, rest:bits>> -> #(token.Semicolon, rest)
    <<",":utf8, rest:bits>> -> #(token.Comma, rest)
    <<"(":utf8, rest:bits>> -> #(token.LParen, rest)
    <<")":utf8, rest:bits>> -> #(token.RParen, rest)
    <<"{":utf8, rest:bits>> -> #(token.LBrace, rest)
    <<"}":utf8, rest:bits>> -> #(token.RBrace, rest)
    <<>> -> #(token.EOF, <<>>)
    illegal -> #(token.Illegal, illegal)
  }
}
