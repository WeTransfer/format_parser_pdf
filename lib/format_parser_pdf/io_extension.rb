module FormatParserPdf
  class Parser
    class IOExtension < FormatParser::IOConstraint
      def initialize(io)
        @io = io
      end

      def seek(n, seek_mode = IO::SEEK_SET)
        case seek_mode
        when IO::SEEK_SET
          @io.seek(n)
        when IO::SEEK_CUR
          @io.seek(@io.pos + n)
        when IO::SEEK_END
          @io.seek(@io.size + n)
        else
          raise Errno::EINVAL
        end
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
