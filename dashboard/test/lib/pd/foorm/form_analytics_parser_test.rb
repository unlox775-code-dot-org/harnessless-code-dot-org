require 'test_helper'

module Pd::Foorm
  class FormAnalyticsParserTest < ActiveSupport::TestCase
    setup_all do
      @form = create :foorm_form_csf_intro_post_survey
      @reshaped_form = FormAnalyticsParser.reshape_form(@form)
    end

    teardown_all {@form.delete}

    test 'reshape_form formats matrix question as expected' do
      assert_includes @reshaped_form, {
        form_id: @form.id,
        form_name: @form.name,
        form_version: @form.version,
        item_type: 'matrix',
        item_name: 'more_prepared',
        item_text: 'I feel more prepared to teach the material covered in this workshop than before I came.',
        matrix_item_name: 'overall_success',
        matrix_item_header: 'How much do you agree or disagree with the following statements about the workshop overall?',
        is_facilitator_specific: 0,
        response_options: ['Strongly Disagree', 'Disagree', 'Slightly Disagree', 'Neutral', 'Slightly Agree', 'Agree', 'Strongly Agree'],
        num_response_options: 7
      }
    end

    test 'reshape_form formats matrix question as expected for facilitator question' do
      assert_includes @reshaped_form, {
        form_id: @form.id,
        form_name: @form.name,
        form_version: @form.version,
        item_type: 'matrix',
        item_name: 'on_track',
        item_text: 'Kept the workshop and participants on track.',
        matrix_item_name: 'facilitator_effectiveness',
        matrix_item_header: 'During my workshop, my facilitator did the following:',
        is_facilitator_specific: 1,
        response_options: ['Strongly Disagree', 'Disagree', 'Slightly Disagree', 'Neutral', 'Slightly Agree', 'Agree', 'Strongly Agree'],
        num_response_options: 7
      }
    end

    test 'reshape_form formats comment question as expected' do
      assert_includes @reshaped_form, {
        form_id: @form.id,
        form_name: @form.name,
        form_version: @form.version,
        item_type: 'text',
        item_name: 'supported',
        item_text: 'What supported your learning the most today and why?',
        is_facilitator_specific: 0
      }
    end

    test 'reshape_form formats single select question as expected' do
      assert_includes @reshaped_form, {
        form_id: @form.id,
        form_name: @form.name,
        form_version: @form.version,
        item_type: 'singleSelect',
        item_name: 'permission',
        item_text: 'I give the workshop organizer permission to quote my written feedback from today for use on social media, promotional materials, and other communications.',
        is_facilitator_specific: 0,
        response_options: ['Yes, I give the workshop organizer permission to quote me and use my name.', 'Yes, I give the workshop organizer permission to quote me, but I want to be anonymous.', 'No, I do not give the workshop organizer my permission.'],
        num_response_options: 3
      }
    end

    test 'reshape_form formats multi select question as expected' do
      form_with_multi_select_question = create :foorm_form, :with_multi_select_question
      reshaped_form_with_multi_select_question = FormAnalyticsParser.reshape_form(form_with_multi_select_question)

      assert_includes reshaped_form_with_multi_select_question, {
        form_id: form_with_multi_select_question.id,
        form_name: form_with_multi_select_question.name,
        form_version: form_with_multi_select_question.version,
        item_type: 'multiSelect',
        item_name: 'not_members_spice_girls',
        item_text: 'Which of the following are NOT names of members of the Spice Girls?',
        is_facilitator_specific: 0,
        response_options: %w(Sporty Radical Spicy Posh Ginger),
        num_response_options: 5
      }
    end
  end
end
