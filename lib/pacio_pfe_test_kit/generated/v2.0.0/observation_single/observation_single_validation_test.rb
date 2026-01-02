require 'us_core_test_kit/validation_test'

module PacioPFETestKit
  module PacioPFEV200
    class ObservationSingleValidationTest < Inferno::Test
      include USCoreTestKit::ValidationTest

      id :pfe_v200_observation_single_validation_test

      title <<~DESC
        Observation resources returned during previous tests conform to the Personal Functioning and Engagement Single Observation
      DESC

      description %(
This test verifies resources returned from the first search conform to
the [Personal Functioning and Engagement Single Observation](http://hl7.org/fhir/us/pacio-pfe/StructureDefinition/pfe-observation-single).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )

      output :dar_code_found, :dar_extension_found

      def resource_type
        'Observation'
      end

      def scratch_resources
        scratch[:observation_single_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/pacio-pfe/StructureDefinition/pfe-observation-single',
                                '2.0.0')
      end
    end
  end
end
