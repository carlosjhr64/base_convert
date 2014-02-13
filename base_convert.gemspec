Gem::Specification.new do |s|

  s.name     = 'base_convert'
  s.version  = '1.0.0'

  s.homepage = 'https://github.com/carlosjhr64/base_convert'

  s.author   = 'CarlosJHR64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2014-02-13'
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
History.txt
README.rdoc
TODO.txt
base_convert.gemspec
lib/base_convert.rb
lib/base_convert/base_convert.rb
lib/base_convert/config.rb
lib/base_convert/functions.rb
lib/base_convert/helpers.rb
lib/base_convert/number.rb
lib/base_convert/version.rb
test/test_base_convert.rb
test/test_functions.rb
test/test_helpers.rb
test/test_number.rb
test/test_original.rb
test/test_original2.rb
test/test_trivial.rb
  )

  s.add_development_dependency 'test-unit', '~> 2.5', '>= 2.5.5'
  s.requirements << 'ruby: ruby 2.1.0p0 (2013-12-25 revision 44422) [x86_64-linux]'

end
