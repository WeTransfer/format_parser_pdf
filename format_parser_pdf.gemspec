
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "format_parser_pdf/version"

Gem::Specification.new do |spec|
  spec.name          = "format_parser_pdf"
  spec.version       = FormatParserPDF::VERSION
  spec.authors       = ["grdw"]
  spec.email         = ["gerard@wetransfer.com"]

  spec.summary       = %q{An adapter for format_parser to parse PDF files using pdf-reader.}
  spec.description   = %q{An adapter for format_parser to parse PDF files using pdf-reader. Replaces the standard PDF parser module.}
  spec.homepage      = "https://github.com/WeTransfer/format_parser_pdf"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'pdf-reader', '~> 2.1'
  spec.add_dependency 'format_parser', '~> 0', '< 1.0'
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "wetransfer_style", "0.6.0"
end
