require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module PacioPFETestKit
  module PacioPFEV200
    class ObservationSinglePatientCodeSearchTest < Inferno::Test
      include PacioPFETestKit::SearchTest

      title 'Server returns valid results for Observation search by patient + code'
      description %(
A server SHALL support searching by
patient + code on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

This test verifies that the server supports searching by reference using
the form `patient=[id]` as well as `patient=Patient/[id]`. The two
different forms are expected to return the same number of results.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of PACIO PFE v2.0.0.

[PACIO PFE Server CapabilityStatement](/CapabilityStatement-pfe.html)

      )

      id :pfe_v200_observation_single_patient_code_search_test
      input :patient_ids,
            title: 'Patient IDs',
            description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'

      def self.properties
        @properties ||= PacioInfernoCore::SearchTestProperties.new(
          first_search: true,
          fixed_value_search: true,
          resource_type: 'Observation',
          search_param_names: ['patient', 'code'],
          possible_status_search: true,
          token_search_params: ['code'],
          test_reference_variants: true,
          test_post_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:observation_single_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
