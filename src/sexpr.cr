# Based on fast-sexpr (https://www.npmjs.com/package/fast-sexpr)

module Sexpr
  extend self

  VERSION = {{ `shards version`.stringify.chomp }}

  alias Node = String | Body
  alias Body = Array(String) | Array(Node)

  class Parser
    private property i = 0
    private property source : String

    module Terms
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

    def parse : Body
      body = [] of Node

      while char = get_char
        if char == ')'
          break
        elsif char == '('
          body << parse
        elsif char == '"'
          body << read_value(Terms::STRING)
        elsif !Terms::SPACE.matches?(char.to_s)
          un_get_char
          body << read_value(Terms::LIST)
          un_get_char
        end
      end

      body
    end
  end

  def remove_comments(source : String) : String
    source.gsub(/;;?.+/, nil)
  end

  def parse(source : String) : Body
    Parser.new(remove_comments(source)).parse
  end
end
