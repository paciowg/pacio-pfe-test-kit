require 'pacio_inferno_core/validation_test'

module PacioPFETestKit
  module PacioPFEV300
    class DeviceValidationTest < Inferno::Test
      include PacioInfernoCore::ValidationTest

      id :pfe_v300_device_validation_test

      title <<~DESC
        Device resources returned during previous tests conform to the Personal Functioning and Engagement Device Profile
      DESC

      description %(
This test verifies resources returned from the first search conform to
the [Personal Functioning and Engagement Device Profile](http://hl7.org/fhir/us/pacio-pfe/StructureDefinition/pfe-device).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )

      output :dar_code_found, :dar_extension_found

      def resource_type
        'Device'
      end

      def scratch_resources
        scratch[:device_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/pacio-pfe/StructureDefinition/pfe-device',
                                '3.0.0-ballot')
      end
    end
  end
end
