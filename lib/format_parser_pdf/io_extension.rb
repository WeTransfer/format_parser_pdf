module FormatParserPDF
  class Parser
    class IOExtension < FormatParser::IOConstraint
      def initialize(io)
        @io = io
      end

      def seek(n, seek_mode = IO::SEEK_SET)
        absolute_offset = case seek_mode
                          when IO::SEEK_SET
            n
                          when IO::SEEK_CUR
            @io.pos + n
                          when IO::SEEK_END
            @io.size + n
          else
            raise Errno::EINVAL
          end

        if absolute_offset < 0
          # Raise a special exception that FormatParser ignores - it will stop the parser and skip to the next one
          msg = "Can only seek to positive absolute offsets (requested seek to #{absolute_offset})"
          raise FormatParser::IOUtils::InvalidRead, msg
        end
        @io.seek(absolute_offset)
      end

      def rewind
        @io.seek(0)
      end

      def readchar
        @io.read(1)
      end

      def getbyte
        if byte = @io.read(1)
          byte.unpack('C').first
        end
      end
    end
  end
end
