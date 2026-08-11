require 'pacio_inferno_core/must_support_test'

module PacioPFETestKit
  module PacioPFEV300_BALLOT
    class DeviceRequestMustSupportTest < Inferno::Test
      include PacioInfernoCore::MustSupportTest

      title 'All must support elements are provided in the DeviceRequest resources returned'

      description %(
        This test will look through the DeviceRequest resources
        found previously for the following must support elements:

        * DeviceRequest.authoredOn
        * DeviceRequest.code[x]
        * DeviceRequest.code[x]:codeCodeableConcept
        * DeviceRequest.encounter
        * DeviceRequest.extension:clinical-justification
        * DeviceRequest.extension:device-user
        * DeviceRequest.extension:location
        * DeviceRequest.groupIdentifier
        * DeviceRequest.insurance
        * DeviceRequest.note
        * DeviceRequest.occurrence[x]
        * DeviceRequest.parameter
        * DeviceRequest.priorRequest
        * DeviceRequest.priority
        * DeviceRequest.requester
        * DeviceRequest.status
        * DeviceRequest.subject
      )

      id :pfe_v300_ballot_device_request_must_support_test

      def resource_type
        'DeviceRequest'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:device_request_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
