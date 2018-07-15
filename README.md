# Format parser PDF

[![Build Status](https://travis-ci.com/WeTransfer/format_parser_pdf.svg?token=9FxKF7M1tP265s2qQFFJ&branch=master)](https://travis-ci.com/WeTransfer/format_parser_pdf)

An extension gem for [format_parser](https://github.com/WeTransfer/format_parser) that uses [pdf-reader](https://github.com/yob/pdf-reader) to detect page count in PDF files.

## Installation

In your `Gemfile`, in addition to the `format_parser` gem add the `format_parser_pdf`:

```ruby
source :rubygems

# ...
gem 'format_parser'
gem 'format_parser_pdf'
```

If you only use `Bundler.setup` in your code and require gems manually, you need to explicitly `require` the library so that the built-in
PDF parser in the `format_parser` gem gets replaced with the extended version. If you use `Bundler.require` it will happen automatically.

## Usage

Anywhere in your code use the standard `FormatParser.parse(io)` calls and related methods, for PDFs the extended version will be used.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/WeTransfer/format_parser_pdf