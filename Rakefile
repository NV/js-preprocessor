require 'spec/rake/spectask'
require 'rake/gempackagetask'

task :default => :spec

# rake spec
Spec::Rake::SpecTask.new do |t|
  t.spec_opts = ['-c', '--format specdoc']
  t.verbose = true
end

def version
  git_describe_tags = `git describe --tags`
  tag = git_describe_tags.split('-').first || git_describe_tags
  tag.strip!
  commits_count_after_last_tag = `git rev-list --full-history #{tag}.. -- bin/ | wc -l`.strip
  "#{tag}.#{commits_count_after_last_tag}"
end

spec = Gem::Specification.new do |s|
  s.name = 'jspp'
  s.version = version
  s.description = 'JavaScript and CSS squasher. Used for building UserJS. Similar to sprockets and juicer.'
  s.summary = 'JavaScript preprocessor'
  s.homepage = 'http://github.com/NV/js-preprocessor'
  s.date = Date.today
  s.authors = ['Nikita Vasilyev']
  s.email = `git log --pretty=format:"%ae" -1`
  s.executables = ['jspp']
  s.test_files = Dir['spec/**/*']
  s.has_rdoc = false
end

# rake gem
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = true
  pkg.need_tar = true
end