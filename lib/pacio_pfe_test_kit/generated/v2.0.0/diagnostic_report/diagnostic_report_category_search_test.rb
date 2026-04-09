require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module PacioPFETestKit
  module PacioPFEV200
    class DiagnosticReportCategorySearchTest < Inferno::Test
      include PacioPFETestKit::SearchTest

      title 'Server returns valid results for DiagnosticReport search by category'
      description %(
A server SHALL support searching by
category on the DiagnosticReport resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[PACIO PFE Server CapabilityStatement](/CapabilityStatement-pfe.html)

      )

      id :pfe_v200_diagnostic_report_category_search_test
      def self.properties
        @properties ||= PacioInfernoCore::SearchTestProperties.new(
          resource_type: 'DiagnosticReport',
          search_param_names: ['category'],
          possible_status_search: true,
          token_search_params: ['category']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:diagnostic_report_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
