require 'pdf-reader'
require 'format_parser'
require 'format_parser_pdf/version'

module FormatParserPdf
  class Parser
    include FormatParser::IOUtils

    PDF_MARKER = /%PDF-1\.[0-9]{1}/

    def call(io)
      io_constraint = FormatParser::IOConstraint.new(io)

      return unless safe_read(io_constraint, 9) =~ PDF_MARKER

      begin
        reader = PDF::Reader.new(io)

        FormatParser::Document.new(format: :pdf, page_count: reader.page_count)
      rescue PDF::Reader::MalformedPDFError
        # Wrong PDF format but should still be a PDF?
        FormatParser::Document.new(format: :pdf)
      end
    end

    FormatParser.register_parser self, natures: :document, formats: :pdf
  end
end
