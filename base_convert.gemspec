Gem::Specification.new do |s|

  s.name     = 'base_convert'
  s.version  = '3.1.191230'

  s.homepage = 'https://github.com/carlosjhr64/base_convert'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2019-12-30'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
BaseConvert - Number base conversion.

Converts positive integers to different bases:
Binary, octal, hexadecimal, decimal, or any arbitrary base.
"Out of the box" handling of up to base 94.
Allows for arbitrary choice of alphabet(digits).
DESCRIPTION

  s.summary = <<SUMMARY
BaseConvert - Number base conversion.
SUMMARY

  s.require_paths = ['lib']
  s.files = %w(
README.md
lib/base_convert.rb
lib/base_convert/base_convert.rb
lib/base_convert/configuration.rb
lib/base_convert/from_to.rb
lib/base_convert/number.rb
  )

  s.requirements << 'ruby: ruby 2.7.0p0 (2019-12-25 revision 647ee6f091) [x86_64-linux]'

end
