Gem::Specification.new do |s|

  s.name     = 'base_convert'
  s.version  = '2.1.0'

  s.homepage = 'https://github.com/carlosjhr64/base_convert'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2017-11-17'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
base_convert - Number base conversion.

Converts positive integers to different bases:
Binary, octal, hexadecimal, decimal, or any arbitrary base.
"Out of the box" handling of up to base 94.
Allows for arbitrary choice of alphabet(digits).
DESCRIPTION

  s.summary = <<SUMMARY
base_convert - Number base conversion.
SUMMARY

  s.extra_rdoc_files = ['README.rdoc']
  s.rdoc_options     = ['--main', 'README.rdoc']

  s.require_paths = ['lib']
  s.files = %w(
README.rdoc
lib/base_convert.rb
lib/base_convert/configuration.rb
lib/base_convert/from_to.rb
lib/base_convert/functions.rb
lib/base_convert/helpers.rb
lib/base_convert/number.rb
  )

  s.requirements << 'ruby: ruby 2.4.2p198 (2017-09-14 revision 59899) [x86_64-linux]'

end
