Gem::Specification.new do |s|

  s.name     = 'base_convert'
  s.version  = '6.0.210201'

  s.homepage = 'https://github.com/carlosjhr64/base_convert'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2021-02-01'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
BaseConvert - Number base conversion.

Converts positive integers to different bases:
Binary, octal, hexadecimal, decimal, or any arbitrary base.
"Out of the box" handling of up to base 95(:print: characters).
Allows for arbitrary choice of alphabet(digits).
DESCRIPTION

  s.summary = <<SUMMARY
BaseConvert - Number base conversion.
SUMMARY

  s.require_paths = ['lib']
  s.files = %w(
README.md
lib/base_convert.rb
lib/base_convert/base.rb
lib/base_convert/base_convert.rb
lib/base_convert/chars.rb
lib/base_convert/configuration.rb
lib/base_convert/digits.rb
lib/base_convert/from_to.rb
lib/base_convert/number.rb
  )

  s.requirements << 'ruby: ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]'

end
