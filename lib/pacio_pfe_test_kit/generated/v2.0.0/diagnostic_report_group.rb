require_relative 'diagnostic_report/pfe_narrative_history_of_status_patient_search_test'
require_relative 'diagnostic_report/pfe_narrative_history_of_status_date_search_test'
require_relative 'diagnostic_report/pfe_narrative_history_of_status_category_search_test'
require_relative 'diagnostic_report/pfe_narrative_history_of_status_status_search_test'
require_relative 'diagnostic_report/pfe_narrative_history_of_status_code_search_test'
require_relative 'diagnostic_report/pfe_narrative_history_of_status_patient_code_date_search_test'
require_relative 'diagnostic_report/pfe_narrative_history_of_status_patient_status_search_test'
require_relative 'diagnostic_report/pfe_narrative_history_of_status_patient_category_date_search_test'
require_relative 'diagnostic_report/pfe_narrative_history_of_status_patient_category_search_test'
require_relative 'diagnostic_report/pfe_narrative_history_of_status_patient_code_search_test'
require_relative 'diagnostic_report/diagnostic_report_read_test'
require_relative 'diagnostic_report/diagnostic_report_validation_test'
require_relative 'diagnostic_report/diagnostic_report_must_support_test'

module PacioPFETestKit
  module PacioPFEV200
    class DiagnosticReportGroup < Inferno::TestGroup
      title 'Personal Functioning and Engagement Narrative History of Status Tests'
      short_description <<~DESC
        'Verify support for the server capabilities required by the Personal Functioning and Engagement Narrative History of Status.'
      DESC
      description %(
# Background

The PFE Personal Functioning and Engagement Narrative History of Status sequence verifies that the system under test is
able to provide correct responses for DiagnosticReport queries. These queries
must contain resources conforming to the Personal Functioning and Engagement Narrative History of Status as
specified in the PFE v2.0.0 Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* patient
* date
* category
* status
* code
* patient + category + date
* patient + category
* patient + code

### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
DiagnosticReport resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the DiagnosticReport resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [Personal Functioning and Engagement Narrative History of Status](http://hl7.org/fhir/us/pacio-pfe/StructureDefinition/pfe-narrative-history-of-status).
Each element is checked against terminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

## Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.

      )

      id :pfe_v200_diagnostic_report
      run_as_group

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(
          YAML.load_file(File.join(__dir__, 'diagnostic_report', 'metadata.yml'), aliases: true)
        )
      end

      test from: :pfe_v200_diagnostic_report_patient_search_test
      test from: :pfe_v200_diagnostic_report_date_search_test
      test from: :pfe_v200_diagnostic_report_category_search_test
      test from: :pfe_v200_diagnostic_report_status_search_test
      test from: :pfe_v200_diagnostic_report_code_search_test
      test from: :pfe_v200_diagnostic_report_patient_code_date_search_test
      test from: :pfe_v200_diagnostic_report_patient_status_search_test
      test from: :pfe_v200_diagnostic_report_patient_category_date_search_test
      test from: :pfe_v200_diagnostic_report_patient_category_search_test
      test from: :pfe_v200_diagnostic_report_patient_code_search_test
      test from: :pfe_v200_diagnostic_report_read_test
      test from: :pfe_v200_diagnostic_report_validation_test
      test from: :pfe_v200_diagnostic_report_must_support_test
  end
end
