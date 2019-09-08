require_relative '../../lib/lexer/lexer'

class Repl
  def start(input)
    l = Lexer.new(input)
    tok = l.next_token
    until(tok.nil?)
      print("Token Type is ", tok.token_type)
      puts("Token is ", tok.literal)
      if(tok.token_type == 'EOF')
        break
      end
      tok = l.next_token
    end
  end
end