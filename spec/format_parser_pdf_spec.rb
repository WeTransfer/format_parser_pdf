require 'spec_helper'

describe 'PDF parser extension' do
  RSpec::Matchers.define :be_pdf_with_pagecount do |page_count|
    match do |actual|
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

  it 'detects the page count in the PDF' do
    parse_result = FormatParser.parse(open_fixture('1_page.pdf'))
    expect(parse_result).to be_pdf_with_pagecount(1)

    parse_result = FormatParser.parse(open_fixture('2_pages.pdf'))
    expect(parse_result).to be_pdf_with_pagecount(2)

    parse_result = FormatParser.parse(open_fixture('3_pages.pdf'))
    expect(parse_result).to be_pdf_with_pagecount(3)

    parse_result = FormatParser.parse(open_fixture('10_pages.pdf'))
    expect(parse_result).to be_pdf_with_pagecount(10)

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

