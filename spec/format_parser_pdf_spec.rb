require 'spec_helper'

describe 'PDF parser extension' do
  RSpec::Matchers.define :be_pdf_with_pagecount do |page_count|
    match(notify_expectation_failures: true) do |actual|
      expect(actual).not_to be_nil
      expect(actual.nature).to eq(:document)
      expect(actual.format).to eq(:pdf)
      expect(actual.page_count).to eq(page_count)
    end
  end

  def fixture_path(filename)
    File.join(__dir__, 'fixtures', filename)
  end

  def open_fixture(filename)
    File.open(fixture_path(filename), 'rb')
  end

  it 'only reads a part of the file when parsing' do
    file = open_fixture('keynote_export.pdf')
    read_spy = FormatParser::ReadLimiter.new(file)

    parse_result = FormatParserPdf::Parser.new.call(read_spy)

    bytes_read = read_spy.bytes
    expect(file.size).to be > (1 * 1024 * 1024) # while the file is about 2MB
    expect(bytes_read).to be < (3 * 1024) # Read is around 1-2 KB
  end

  it 'detects the page count in the PDF' do
    parse_result = FormatParser.parse(open_fixture('1_page.pdf'))
    expect(parse_result).to be_pdf_with_pagecount(1)

    parse_result = FormatParser.parse(open_fixture('2_pages.pdf'))
    expect(parse_result).to be_pdf_with_pagecount(2)

    parse_result = FormatParser.parse(open_fixture('3_pages.pdf'))
    expect(parse_result).to be_pdf_with_pagecount(3)

    parse_result = FormatParser.parse(open_fixture('10_pages.pdf'))
    expect(parse_result).to be_pdf_with_pagecount(10)

    parse_result = FormatParser.parse(open_fixture('keynote_export.pdf'))
    expect(parse_result).to be_pdf_with_pagecount(4)
  end
  
  it 'returns nil when trying to parse a broken PDF or a document that is not a PDF' do
    parse_result = FormatParser.parse(open_fixture('missing_page_count.pdf'))
    expect(parse_result).to be_nil

    parse_result = FormatParser.parse(open_fixture('not_a.pdf'))
    expect(parse_result).to be_nil

    parse_result = FormatParser.parse(open_fixture('broken.pdf'))
    expect(parse_result).to be_nil
  end
end
