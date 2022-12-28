Gem::Specification.new do |s|

  s.name     = 'base_convert'
  s.version  = '7.1.221228'

  s.homepage = 'https://github.com/carlosjhr64/base_convert'

  s.author   = 'CarlosJHR64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2022-12-28'
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
lib/base_convert/chars.rb
lib/base_convert/digits.rb
lib/base_convert/from_to.rb
lib/base_convert/methods.rb
lib/base_convert/number.rb
  )

  s.requirements << 'ruby: ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [aarch64-linux]'

end
