# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{nanowrimo}
  s.version = "0.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Joshua Clingenpeel"]
  s.date = %q{2009-05-25}
  s.description = %q{A simple API wrapper for Nanowrimo.org. Nanowrimo Word Count API documentation here: http://www.nanowrimo.org/eng/wordcount_api}
  s.email = ["joshua.clingenpeel@gmail.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt", "Rakefile", "lib/nanowrimo.rb", "lib/nanowrimo/genre.rb", "lib/nanowrimo/region.rb", "lib/nanowrimo/site.rb", "lib/nanowrimo/user.rb", "test/test_nanowrimo.rb", "test/test_genre.rb", "test/test_region.rb", "test/test_site.rb", "test/test_user.rb", "test/fixtures/genre_wc.xml", "test/fixtures/genre_wc_history.xml", "test/fixtures/region_wc.xml", "test/fixtures/region_wc_history.xml", "test/fixtures/site_wc.xml", "test/fixtures/site_wc_history.xml", "test/fixtures/user_page.htm", "test/fixtures/user_wc.xml", "test/fixtures/user_wc_history.xml"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/illuminerdi/nanowrimo}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{nanowrimo}
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{A simple API wrapper for Nanowrimo.org}
  s.test_files = ["test/test_genre.rb", "test/test_nanowrimo.rb", "test/test_region.rb", "test/test_site.rb", "test/test_user.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 1.7.0"])
      s.add_development_dependency(%q<nokogiri>, [">=1.2.3"])
    else
      s.add_dependency(%q<hoe>, [">= 1.7.0"])
      s.add_dependency(%q<nokogiri>, [">=1.2.3"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 1.7.0"])
    s.add_dependency(%q<nokogiri>, [">=1.2.3"])
  end
end