require 'spec_helper'

describe 'pdf reader overrides' do
  let(:pdf) {
    File.open(
      Pathname.new(fixtures_dir).join(pdf_file),
      'rb'
    )
  }

  describe 'skips stream objects' do
    let(:pdf_file) { '10_pages.pdf' }

    describe 'PDF::Reader with overrides' do
      it 'using the overrides' do
        dump_streams = PDF::Reader.new(pdf).pages.map(&:raw_content).join

        expect(dump_streams).to be_empty
      end
    end
  end
end
