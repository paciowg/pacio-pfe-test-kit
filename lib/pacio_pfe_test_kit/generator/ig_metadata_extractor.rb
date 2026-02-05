require 'us_core_test_kit/generator/ig_metadata_extractor'
require_relative 'ig_metadata'
require_relative 'group_metadata_extractor'

module PacioPFETestKit
  class Generator
    class IGMetadataExtractor < USCoreTestKit::Generator::IGMetadataExtractor
      def initialize(ig_resources)
        super
        add_patient_resource
        fix_search_parameter_name
        self.metadata = IGMetadata.new
      end

      # PACIO PFE 2.0 CapabilityStatement does not include Patient profile. Since PFE IG
      # is a patient compartment IG, Patient shall be included.
      def add_patient_resource
        resources_in_capability_statement << FHIR::CapabilityStatement::Rest::Resource.new(
          {
            type: 'Patient',
            supportedProfile: [
              'http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient'
            ],
            interaction: [
              {
                extension: [
                  {
                    url: 'http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation',
                    valueCode: 'SHALL'
                  }
                ],
                code: 'search-type'
              },
              {
                extension: [
                  {
                    url: 'http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation',
                    valueCode: 'SHALL'
                  }
                ],
                code: 'read'
              }
            ],
            searchParam: [
              {
                extension: [
                  {
                    url: 'http://hl7.org/fhir/StructureDefinition/capabilitystatement-expectation',
                    valueCode: 'SHALL'
                  }
                ],
                name: '_id',
                definition: 'http://hl7.org/fhir/us/core/SearchParameter/us-core-patient-id|6.1.0',
                type: 'token',
                documentation: 'https://www.hl7.org/fhir/us/core/SearchParameter-us-core-patient-id.html'
              }
            ]
          }
        )
      end

      # PFE v2.0.0 has some parameter name with blank space. Replace blank space with dash
      # PFE v2.0.0 has parameter name "status" for Condition profile. The name should be "clinical-status"
      def fix_search_parameter_name
        resources_in_capability_statement.each do |resource|
          resource.searchParam.each do |param|
            param.name.gsub!(' ', '-')

            param.name = 'clinical-status' if (resource.type == 'Condition') && param.name == 'status'
          end
        end
      end

      def remove_extra_supported_profiles
        # NO extra profiles to be removed.
      end

      def add_metadata_from_resources
        metadata.groups =
          resources_in_capability_statement.flat_map do |resource|
            resource.supportedProfile&.map do |supported_profile|
              GroupMetadataExtractor.new(resource, supported_profile, metadata, ig_resources).group_metadata
            end
          end.compact

        metadata.postprocess_groups(ig_resources)
      end
    end
  end
end
