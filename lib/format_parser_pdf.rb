require 'pdf-reader'
require 'format_parser'
require 'format_parser_pdf/io_extension'
require 'format_parser_pdf/version'

module FormatParserPDF
  class Parser
    include FormatParser::IOUtils

    PDF_MARKER = /%PDF-1\.[0-9]{1}/

    def call(io)
      io = FormatParser::IOConstraint.new(io)

      return unless safe_read(io, 9) =~ PDF_MARKER
      parse_using_pdf_reader(io)
    end

    def parse_using_pdf_reader(io)
      pdf_reader = PDF::Reader.new(IOExtension.new(io))
      page_count = pdf_reader.page_count
      FormatParser::Document.new(format: :pdf, page_count: page_count)
    rescue PDF::Reader::MalformedPDFError
      nil
    end
  end

  FormatParser.deregister_parser(FormatParser::PDFParser)
  FormatParser.register_parser Parser, natures: :document, formats: :pdf
end
