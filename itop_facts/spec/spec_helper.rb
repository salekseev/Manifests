require 'rspec-puppet'
module RSpec::Puppet
      module FunctionExampleGroup
          include RSpec::Puppet::Support
          alias_method :subject_orig, :subject
          def subject
              Facter.reset()
              return self.subject_orig()
          end
      end
end
fixture_path = File.expand_path(File.join(__FILE__,'..','fixtures'))
RSpec.configure do |c|
  c.module_path = File.join(File.dirname(__FILE__), '../../')
  c.manifest_dir = File.join(fixture_path, 'manifests')
  c.mock_with :rspec
end
