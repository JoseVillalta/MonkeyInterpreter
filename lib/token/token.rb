class Token
  ILLEGAL = 'ILLEGAL'
  EOF = 'EOF'

  # Identifiers
  IDENT = 'IDENT'
  INT = 'INT'

  # Operators
  ASSIGN = '='
  PLUS = '+'

  # Delimiters
  COMMA = ','
  SEMMICOLON = ';'

  LPAREN = '('
  RPAREN = ')'
  LBRACE = '{'
  RBRACE = '}'

  # Keywords
  FUNCTION = 'FUNCTION'
  LET = 'LET'

  attr_accessor :token_type
  attr_accessor :literal
  attr_accessor :keyword_map
  def initialize(token_type, literal)
    @token_type = token_type
    @literal = literal
    @keykord_map = { 'fun' => "FUNCTION", 'let' => "LET"}
  end

  def lookup_ident(identifier)
    if(@keykord_map.key?(identifier))
      return @keykord_map[identifier]
    else
      return IDENT
    end
  end


end


