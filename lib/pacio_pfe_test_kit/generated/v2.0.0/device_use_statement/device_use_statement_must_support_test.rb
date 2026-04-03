require 'pacio_inferno_core/must_support_test'

module PacioPFETestKit
  module PacioPFEV200
    class DeviceUseStatementMustSupportTest < Inferno::Test
      include PacioInfernoCore::MustSupportTest

      title 'All must support elements are provided in the DeviceUseStatement resources returned'

      description %(
        This test will look through the DeviceUseStatement resources
        found previously for the following must support elements:


      )

      id :pfe_v200_device_use_statement_must_support_test

      def resource_type
        'DeviceUseStatement'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:device_use_statement_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
