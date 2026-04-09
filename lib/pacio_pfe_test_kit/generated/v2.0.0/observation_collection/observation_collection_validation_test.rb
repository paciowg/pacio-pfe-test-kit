require 'pacio_inferno_core/validation_test'

module PacioPFETestKit
  module PacioPFEV200
    class ObservationCollectionValidationTest < Inferno::Test
      include PacioInfernoCore::ValidationTest

      id :pfe_v200_observation_collection_validation_test

      title <<~DESC
        Observation resources returned during previous tests conform to the Personal Functioning and Engagement Collection
      DESC

      description %(
This test verifies resources returned from the first search conform to
the [Personal Functioning and Engagement Collection](http://hl7.org/fhir/us/pacio-pfe/StructureDefinition/pfe-collection).
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
        scratch[:observation_collection_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/pacio-pfe/StructureDefinition/pfe-collection',
                                '2.0.0')
      end
    end
  end
end
