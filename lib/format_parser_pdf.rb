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
      # We might want to recover more useful items (such as page dimensions -
      # media box, trim box, bleed box, art box and a few dozens other boxes)
      # later on. At the moment FormatParser::Document does not have `intrinsics' which
      # is an omission we need to sort out on format_parser itself
      # intrinsics = {
      #   pdf_version: pdf_reader.pdf_version,
      #   info: pdf_reader.info,
      #   metadata: pdf_reader.metadata,
      # }
      FormatParser::Document.new(format: :pdf, page_count: page_count) #, intrinsics: intrinsics)
    rescue PDF::Reader::MalformedPDFError
      nil
    end
  end

  # FormatParser includes a builtin PDF parser that only checks for the PDF magic comment
  # at the start of file. That one needs to be disabled first
  FormatParser.deregister_parser(FormatParser::PDFParser)

  # ...and replaced with ours
  FormatParser.register_parser Parser, natures: :document, formats: :pdf
end
