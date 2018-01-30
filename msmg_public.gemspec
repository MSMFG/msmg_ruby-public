class << $LOAD_PATH
  def merge!(other)
    replace(self | other)
  end
end

$LOAD_PATH.merge! [File.expand_path('../lib', __FILE__)]

Gem::Specification.new do |spec|
  raise 'RubyGems 2.0 or newer is required.' unless spec.respond_to?(:metadata)
  spec.name = 'msmg_public'
  spec.version = '0.2.0'
  spec.authors = ['Andrew Smith']
  spec.email = ['andrew.smith at moneysupermarket.com']

  spec.summary = 'Various Ruby Sources'
  spec.description = 'MSM pubicly available Ruby'
  spec.homepage = 'https://github.com/MSMFG/msmg_ruby-public'
  spec.license = 'Apache-2.0'
  spec.files = `git ls-files -z`.split("\x0")
end
