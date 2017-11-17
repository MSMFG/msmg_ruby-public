# Tests

require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new(:test) do |t|
  t.libs |= %w[
    test
    lib
  ]
  t.test_files = FileList['test/unit/**/test_*.rb']
end

RuboCop::RakeTask.new(:rubocop) do |t|
  t.fail_on_error = true
end

task default: %i[test rubocop]
