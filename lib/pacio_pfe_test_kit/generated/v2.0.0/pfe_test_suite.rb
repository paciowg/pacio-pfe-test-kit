require 'inferno/dsl/oauth_credentials'
require_relative '../../version'
require_relative '../../custom_groups/v2.0.0/capability_statement_group'
require_relative 'patient_group'
require_relative 'observation_clinicaltest_group'
require_relative 'collection_group'
require_relative 'observation_single_group'
require_relative 'diagnostic_report_group'
require_relative 'condition_encounter_diagnosis_group'
require_relative 'condition_problems_health_concerns_group'
require_relative 'goal_group'
require_relative 'service_request_group'
require_relative 'device_use_statement_group'
require_relative 'nutrition_order_group'

module PacioPFETestKit
  module PacioPFEV200
    class PacioPFETestSuite < Inferno::TestSuite
      title 'PACIO PFE Server v2.0.0'
      description %(
        The PACIO PFE Server Test Kit tests server systems for their conformance to the [PACIO PFE
        Implementation Guide](https://hl7.org/fhir/us/pacio-pfe/STU2).
      )

      GENERAL_MESSAGE_FILTERS = [].freeze

      VERSION_SPECIFIC_MESSAGE_FILTERS = [].freeze

      VALIDATION_MESSAGE_FILTERS = GENERAL_MESSAGE_FILTERS + VERSION_SPECIFIC_MESSAGE_FILTERS

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
          Generator::GroupMetadata.new(raw_metadata)
        end
      end

      id :pfe_v200

      fhir_resource_validator do
        igs 'hl7.fhir.us.pacio-pfe#2.0.0', 'hl7.fhir.us.core#6.1.0'
        message_filters = VALIDATION_MESSAGE_FILTERS

        exclude_message do |message|
          message_filters.any? { |filter| filter.match? message.message }
        end
      end

      input :url,
            title: 'FHIR Endpoint',
            description: 'URL of the FHIR endpoint'
      input :smart_auth_info,
            title: 'OAuth Credentials',
            type: :auth_info,
            optional: true

      fhir_client do
        url :url
        auth_info :smart_auth_info
      end

      group from: :pfe_v200_capability_statement

      group from: :pfe_v200_patient
      group from: :pfe_v200_observation_clinicaltest
      group from: :pfe_v200_collection
      group from: :pfe_v200_observation_single
      group from: :pfe_v200_diagnostic_report
      group from: :pfe_v200_condition_encounter_diagnosis
      group from: :pfe_v200_condition_problems_health_concerns
      group from: :pfe_v200_goal
      group from: :pfe_v200_service_request
      group from: :pfe_v200_device_use_statement
      group from: :pfe_v200_nutrition_order

      links [
        {
          type: 'report_issue',
          label: 'Report Issue',
          url: 'https://github.com/paciowg/pacio-pfe-test-kit/issues/'
        },
        {
          type: 'source_code',
          label: 'Open Source',
          url: 'https://github.com/paciowg/pacio-pfe-test-kit/'
        },
        {
          type: 'download',
          label: 'Download',
          url: 'https://github.com/paciowg/pacio-pfe-test-kit/releases/'
        }
      ]
    end
  end
end
