require "bundler/setup"
require "format_parser_pdf"

module SpecHelpers
  def fixtures_dir
    __dir__ + '/fixtures'
  end
end

RSpec.configure do |config|
  config.include SpecHelpers
  config.extend SpecHelpers
end
