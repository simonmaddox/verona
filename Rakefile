require 'bundler/setup'

gemspec = eval(File.read("verona.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["verona.gemspec"] do
  system "gem build verona.gemspec"
end
