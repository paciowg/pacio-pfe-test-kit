module PacioPFETestKit
  class Generator
    module Naming
      SHORT_NAME = 'PFE'.freeze
      # From PFE

      # From US Core
      PATIENT = 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient'

      IG_LINKS = {
        'v2.0.0' => 'https://hl7.org/fhir/us/pacio-pfe/STU2'
      }.freeze

      class << self
        def resources_with_multiple_profiles
          ['Condition', 'Observation']
        end

        def prefix
          'pfe'
        end

        def module_name
          'PacioPFE'
        end

        def long_name
          'PACIO PFE'
        end

        def resource_has_multiple_profiles?(resource)
          resources_with_multiple_profiles.include? resource
        end

        def snake_case_for_profile(group_metadata)
          resource = group_metadata.resource
          return resource.underscore unless resource_has_multiple_profiles?(resource)

          return 'observation_collection' if group_metadata.name == 'pfe_collection'
          
          group_metadata.name
            .delete_prefix("#{prefix}_")
            .underscore
        end

        def upper_camel_case_for_profile(group_metadata)
          snake_case_for_profile(group_metadata).camelize
        end

        def ig_link(version)
          IG_LINKS[version]
        end
      end
    end
  end
end
