require 'simplecov'
SimpleCov.command_name 'test:unit'
SimpleCov.start do
  add_group 'Libs', 'lib/'
  track_files 'lib/*.rb'
  add_filter '/test/'
end
