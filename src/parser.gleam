import gleam/io
import gleam/list
import gleam/bit_array
import parser/token

pub fn main() {
  let result = lex("let five = 5; (){}; $ %,<>=+-*/")
  io.debug(result)
}

pub fn lex(input: String) -> List(token.Token) {
  input
  |> bit_array.from_string()
  |> do_lex([])
}

fn do_lex(input, tokens) {
  case input {
    <<>> -> list.reverse([token.EOF, ..tokens])

    // scape white_spaces characters
    <<" ":utf8, rest:bits>> -> do_lex(rest, tokens)
    <<"\n":utf8, rest:bits>> -> do_lex(rest, tokens)
    <<"\r":utf8, rest:bits>> -> do_lex(rest, tokens)
    <<"\t":utf8, rest:bits>> -> do_lex(rest, tokens)
    _ -> {
      let assert #(tok, rest) = tokenize(input)
      io.debug(#(tok, rest))
      do_lex(rest, [tok, ..tokens])
    }
  }
}

fn tokenize(input: BitArray) -> #(token.Token, BitArray) {
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
    <<c:8, rest:bits>> -> {
      case is_letter(c) {
        True -> read_identifier(rest, <<c>>)
        _ ->
          case is_number(c) {
            True -> read_number(rest, <<c>>)
            _ -> #(token.Illegal(<<c>>), rest)
          }
      }
    }
    _ -> panic as "should not reach this point"
  }
}

fn read_identifier(input, acc) {
  case input {
    <<c:8, rest:bits>> -> {
      case is_letter(c) {
        True -> read_identifier(rest, bit_array.append(acc, <<c>>))
        _ -> #(token.keyword(acc), input)
      }
    }
    _ -> #(token.keyword(acc), input)
  }
}

fn read_number(input, acc) {
  case input {
    <<c:8, rest:bits>> ->
      case is_number(c) {
        True -> read_number(rest, bit_array.append(acc, <<c>>))
        _ -> #(token.Int(acc), input)
      }
    _ -> #(token.Int(acc), input)
  }
}

fn is_letter(input: Int) -> Bool {
  let assert <<lower_a, lower_z, upper_a, upper_z>> = <<"azAZ":utf8>>

  { lower_a <= input && input <= lower_z }
  || { upper_a <= input && input <= upper_z }
}

fn is_number(input: Int) -> Bool {
  let assert <<zero, nine>> = <<"09":utf8>>
  zero <= input && input <= nine
}
