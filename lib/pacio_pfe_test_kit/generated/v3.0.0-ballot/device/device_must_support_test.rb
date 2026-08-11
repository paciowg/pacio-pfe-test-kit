require 'pacio_inferno_core/must_support_test'

module PacioPFETestKit
  module PacioPFEV300_BALLOT
    class DeviceMustSupportTest < Inferno::Test
      include PacioInfernoCore::MustSupportTest

      title 'All must support elements are provided in the Device resources returned'

      description %(
        This test will look through the Device resources
        found previously for the following must support elements:

        * Device.deviceName
        * Device.distinctIdentifier
        * Device.expirationDate
        * Device.lotNumber
        * Device.manufactureDate
        * Device.owner
        * Device.patient
        * Device.serialNumber
        * Device.type
        * Device.udiCarrier
        * Device.udiCarrier.carrierHRF
        * Device.udiCarrier.deviceIdentifier
      )

      id :pfe_v300_ballot_device_must_support_test

      def resource_type
        'Device'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:device_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
