module PacioPFETestKit
  class ProfileSupportTest < Inferno::Test
    id :pfe_profile_support
    title 'Capability Statement lists support for required PACIO PFE Profiles'
    description %(
      The PACIO PFE Implementation Guide states:

      ```
      The PFE Server SHALL:
      1. Support all profiles defined in this Implementation Guide.
      ```
    )
    uses_request :capability_statement

    run do
      assert_resource_type(:capability_statement)
      capability_statement = resource

      supported_profiles = capability_statement.rest&.flat_map do |rest|
        rest.resource.flat_map do |resource|
          # Remove trailing version from canonical url
          resource.supportedProfile&.map { |profile| profile.split('|').first }
        end.compact
      end&.uniq || []

      if config.options[:required_profiles].present?
        required_profiles = config.options[:required_profiles]

        missing_profiles = required_profiles - supported_profiles

        missing_profiles_list =
          missing_profiles
            .map { |resource| "`#{resource}`" }
            .join(', ')

        assert missing_profiles.empty?,
               'The CapabilityStatement does not list support for the following' \
               "PACIO PFE profiles: #{missing_profiles_list}"
      end
    end
  end
end
