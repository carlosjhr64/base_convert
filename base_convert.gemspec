Gem::Specification.new do |s|

  s.name     = 'base_convert'
  s.version  = '2.0.0'

  s.homepage = 'https://github.com/carlosjhr64/base_convert'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2014-12-03'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
base_convert - Number base conversion.

Converts positive integers to different bases:
Binary, octal, hexadecimal, decimal, or any arbitrary base.
"Out of the box" handling of up to base 91.
Allows for arbitrary choice of alphabet(digits).
DESCRIPTION

  s.summary = <<SUMMARY
base_convert - Number base conversion.
SUMMARY

  s.extra_rdoc_files = ['README.rdoc']
  s.rdoc_options     = ["--main", "README.rdoc"]

  s.require_paths = ["lib"]
  s.files = %w(
README.rdoc
lib/base_convert.rb
lib/base_convert/configuration.rb
lib/base_convert/from_to.rb
lib/base_convert/functions.rb
lib/base_convert/helpers.rb
lib/base_convert/number.rb
lib/base_convert/version.rb
  )

  s.requirements << 'ruby: ruby 2.1.3p242 (2014-09-19 revision 47630) [x86_64-linux]'
  s.requirements << 'join: join (GNU coreutils) 8.21'

end
