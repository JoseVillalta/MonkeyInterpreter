require_relative '../token/token'

class Lexer
  attr_accessor :input
  attr_accessor :position
  attr_accessor :read_position
  attr_accessor :ch

  def initialize(input)
    @input = input
    @read_position = 0
    @position = 0
    read_char
  end

  def read_char
    @read_position >= input.length ? @ch = 0 : @ch = @input[@read_position]
    @position = @read_position
    @read_position += 1
    end


  def next_token
    skip_whitespace
    case @ch
    when '='
      tok = Token.new('ASSIGN','=')
    when ';'
      tok = Token.new('SEMICOLON', ';')
    when '('
      tok = Token.new('LPAREN', '(')
    when ')'
      tok = Token.new('RPAREN', ')')
    when '{'
      tok = Token.new('LBRACE', '{')
    when '}'
      tok = Token.new('RBRACE', '}')
    when ','
      tok = Token.new('COMMA', ',')
    when '+'
      tok = Token.new('PLUS', '+')
    when 0
      tok = Token.new('EOF', "")
    else
      if(is_letter)
        literal = read_identifier
        tok = Token.new('IDENT', literal)
        token_type = tok.lookup_ident(literal)
        tok.token_type = token_type
        return tok
      elsif(is_digit)
        tok = Token.new('INT', read_number)
        return tok
      else
        tok = Token.new('ILLEGAL', @ch)
      end
    end

    read_char
    return tok
  end

  def is_letter
    return ('a' <= @ch && @ch <= 'z' )|| ('A' <= @ch && @ch <= 'Z') || @ch == '_'
  end

  def read_identifier
    pos = @position
    while(is_letter)
      read_char
    end
    return input[pos, @position - pos]
  end

  def is_digit
   return '0' <= @ch && @ch <= '9'
  end

  def read_number
    pos = @position
    while(is_digit)
      read_char
    end
    return input[pos, @position - pos]
  end

  def skip_whitespace
    if @ch == 0
      return
    end
    while(@ch.match(/\s/))
      read_char
    end
  end

end