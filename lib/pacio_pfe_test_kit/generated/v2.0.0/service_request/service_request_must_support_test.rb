require 'us_core_test_kit/must_support_test'

module PacioPFETestKit
  module PacioPFEV200
    class ServiceRequestMustSupportTest < Inferno::Test
      include USCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the ServiceRequest resources returned'

      description %(
        This test will look through the ServiceRequest resources
        found previously for the following must support elements:

        * ServiceRequest.authoredOn
        * ServiceRequest.category
        * ServiceRequest.category:us-core
        * ServiceRequest.code
        * ServiceRequest.intent
        * ServiceRequest.note
        * ServiceRequest.occurrencePeriod
        * ServiceRequest.orderDetail
        * ServiceRequest.reasonReference
        * ServiceRequest.requester
        * ServiceRequest.status
        * ServiceRequest.subject
      )

      id :pfe_v200_service_request_must_support_test

      def resource_type
        'ServiceRequest'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:service_request_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
