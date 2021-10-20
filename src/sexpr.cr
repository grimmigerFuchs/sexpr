# Based on fast-sexpr (https://www.npmjs.com/package/fast-sexpr)

module Sexpr
  extend self

  VERSION = {{ `shards version`.stringify.chomp }}

  module AST
    abstract struct Node
      property value

      def initialize(@value)
      end
    end

    struct Body < Node
      property value : Array(Node)

      def initialize
        @value = [] of Node
      end

      def <<(other : Node) : self
        @value << other

        self
      end

      def <<(other : self) : self
        self << other.value
      end
    end

    struct SymNode < Node
      property value : String
    end

    struct StringNode < Node
      property value : String
    end
  end

  private class Wrapper
    private property i = 0
    private property source : String

    private module Terms
      STRING = /"/
      SPACE  = /\s/
      LIST   = /(#{SPACE})|[()]/
    end

    def initialize(@source : String)
    end

    private def get_char : Char?
      if @i == @source.size
        return nil
      end

      char = @source[@i]
      @i += 1
      char
    end

    private def read_value(is_terminator : Regex) : String
      value = ""
      while !is_terminator.matches?(strChar = get_char.to_s)
        value += strChar
      end

      value
    end

    private def un_get_char
      @i -= 1
    end

    def parse : AST::Body
      body = AST::Body.new

      while char = get_char
        if char == ')'
          break
        elsif char == '('
          body << parse
        elsif char == '"'
          body << AST::StringNode.new(read_value(Terms::STRING))
        elsif !Terms::SPACE.matches?(char.to_s)
          un_get_char
          body.value << AST::SymNode.new(read_value(Terms::LIST))
          un_get_char
        end
      end

      body
    end
  end

  def remove_comments(source : String) : String
    source.gsub(/;;?.+/, nil)
  end

  def parse(source : String) : AST::Body
    Wrapper.new(remove_comments(source)).parse
  end
end
