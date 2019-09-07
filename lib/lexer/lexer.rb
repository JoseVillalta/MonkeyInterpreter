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
      if peek_char == '='
        ch = @ch
        read_char
        tok = Token.new('EQ', ch + @ch)
      else
        tok = Token.new('ASSIGN','=')
      end
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
    when '!'
      if peek_char == '='
        ch = @ch
        read_char
        tok = Token.new('NOT_EQ', ch + @ch)
      else
        tok = Token.new('BANG', '!')
      end
    when '-'
      tok = Token.new('MINUS', '-')
    when '*'
      tok = Token.new('ASTERISK', '*')
    when '/'
      tok = Token.new('SLASH', '/')
    when '<'
      tok = Token.new('LT', '<')
    when '>'
      tok = Token.new('GT', '>')
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

  def peek_char
    if @read_position >= input.length
      return 0
    else
      return input[@read_position]
    end
  end

end