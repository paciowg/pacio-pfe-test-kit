require 'us_core_test_kit/validation_test'

module PacioPFETestKit
  module PacioPFEV200
    class DeviceUseStatementValidationTest < Inferno::Test
      include USCoreTestKit::ValidationTest

      id :pfe_v200_device_use_statement_validation_test

      title <<~DESC
        DeviceUseStatement resources returned during previous tests conform to the Personal Functioning and Engagement Use of Device
      DESC

      description %(
This test verifies resources returned from the first search conform to
the [Personal Functioning and Engagement Use of Device](http://hl7.org/fhir/us/pacio-pfe/StructureDefinition/pfe-use-of-device).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )

      output :dar_code_found, :dar_extension_found

      def resource_type
        'DeviceUseStatement'
      end

      def scratch_resources
        scratch[:device_use_statement_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org/fhir/us/pacio-pfe/StructureDefinition/pfe-use-of-device',
                                '2.0.0')
      end
    end
  end
end
