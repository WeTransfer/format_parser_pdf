require 'pdf-reader'
require 'format_parser'
require 'format_parser_pdf/io_extension'
require 'format_parser_pdf/version'

module FormatParserPdf
  class Parser
    include FormatParser::IOUtils

    PDF_MARKER = /%PDF-1\.[0-9]{1}/

    def call(io)
      io = FormatParser::IOConstraint.new(io)

      return unless safe_read(io, 9) =~ PDF_MARKER

      begin
        pdf_reader = PDF::Reader.new(IOExtension.new(io))

        FormatParser::Document.new(
          format: :pdf,
          page_count: pdf_reader.page_count
        )
      rescue PDF::Reader::MalformedPDFError
      end
    end

    FormatParser.register_parser self, natures: :document, formats: :pdf
  end
end
