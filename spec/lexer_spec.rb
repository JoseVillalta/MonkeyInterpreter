require 'rspec'
require_relative '../lib/lexer/lexer'
require_relative '../lib/token/token'

describe 'Lexer' do

  it 'returns tokens' do
    input = '=+(){},;'
    tests = [
                Token.new('ASSIGN','='),
                Token.new('PLUS', '+'),
                Token.new('LPAREN', '('),
                Token.new('RPAREN', ')'),
                Token.new('LBRACE', '{'),
                Token.new('RBRACE', '}'),
                Token.new('COMMA', ','),
                Token.new('SEMICOLON', ';'),
                Token.new('EOF', "") ]

    l = Lexer.new(input)
    tests.each do |expected_token|
      tok = l.next_token
      expect(tok.token_type).to eq(expected_token.token_type)
      expect(tok.literal).to eq(expected_token.literal)
    end
  end
  it 'returns more tokens' do
    input = 'let five = 5;
    let ten = 10;

    let add = fn(x, y){
     x + y;
    };

    let result = add(five, ten);'
    tests = [
        Token.new('LET', 'let'),
        Token.new('IDENT', 'five'),
        Token.new('ASSIGN', '='),
        Token.new('INT', '5'),
        Token.new('SEMICOLON', ';'),
        Token.new('LET', 'let'),
        Token.new('IDENT', 'ten'),
        Token.new('ASSIGN', '='),
        Token.new('INT', '10'),
        Token.new('SEMICOLON', ';'),
        Token.new('LET', 'let'),
        Token.new('IDENT', 'add'),
        Token.new('ASSIGN', '='),
        Token.new('IDENT', 'fn'),
        Token.new('LPAREN', '('),
        Token.new('IDENT', 'x'),
        Token.new('COMMA', ','),
        Token.new('IDENT', 'y'),
        Token.new('RPAREN', ')'),
        Token.new('LBRACE', '{'),
        Token.new('IDENT', 'x'),
        Token.new('PLUS', '+'),
        Token.new('IDENT', 'y'),
        Token.new('SEMICOLON', ';'),
        Token.new('RBRACE', '}'),
        Token.new('SEMICOLON', ';'),
        Token.new('LET', 'let'),
        Token.new('IDENT', 'result'),
        Token.new('ASSIGN', '='),
        Token.new('IDENT', 'add'),
        Token.new('LPAREN', '('),
        Token.new('IDENT', 'five'),
        Token.new('COMMA', ','),
        Token.new('IDENT', 'ten'),
        Token.new('RPAREN', ')'),
        Token.new('SEMICOLON', ';'),
        Token.new('EOF', "")
    ]

    l = Lexer.new(input)
    tests.each do |expected_token|
      tok = l.next_token
      expect(tok.token_type).to eq(expected_token.token_type)
      expect(tok.literal).to eq(expected_token.literal)
    end
  end
  it 'gets identifier' do
    input = 'let five = 5;'
    l = Lexer.new(input)
    var = l.next_token
    expect(var.literal).to eq('let')
    expect(var.token_type).to eq('LET')
    var = l.next_token
    expect(var.token_type).to eq('IDENT')
    expect(var.literal).to eq('five')
  end
end