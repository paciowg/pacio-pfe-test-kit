require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module PacioPFETestKit
  module PacioPFEV200
    class ObservationCollectionPatientCategorySearchTest < Inferno::Test
      include PacioPFETestKit::SearchTest

      title 'Server returns valid results for Observation search by patient + category'
      description %(
A server SHALL support searching by
patient + category on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[PACIO PFE Server CapabilityStatement](/CapabilityStatement-pfe.html)

      )

      id :pfe_v200_observation_collection_patient_category_search_test
      input :patient_ids,
            title: 'Patient IDs',
            description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'

      def self.properties
        @properties ||= PacioInfernoCore::SearchTestProperties.new(
          resource_type: 'Observation',
          search_param_names: ['patient', 'category'],
          possible_status_search: true,
          token_search_params: ['category']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:observation_collection_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
