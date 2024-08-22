# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2024_08_07_174943) do

  create_table "activities", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "user_id"
    t.integer "level_id"
    t.string "action"
    t.string "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "attempt"
    t.integer "time"
    t.integer "test_result"
    t.integer "level_source_id"
    t.integer "lines", default: 0, null: false
    t.index ["level_source_id"], name: "index_activities_on_level_source_id"
    t.index ["user_id", "level_id"], name: "index_activities_on_user_id_and_level_id"
  end

  create_table "activity_sections", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "lesson_activity_id", null: false
    t.string "key", null: false
    t.integer "position", null: false
    t.text "properties"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_activity_sections_on_key", unique: true
    t.index ["lesson_activity_id"], name: "index_activity_sections_on_lesson_activity_id"
  end

  create_table "ai_tutor_interaction_feedbacks", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.bigint "ai_tutor_interaction_id", null: false
    t.integer "user_id", null: false
    t.boolean "thumbs_up"
    t.boolean "thumbs_down"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "details"
    t.index ["ai_tutor_interaction_id", "user_id"], name: "index_ai_tutor_feedback_on_interaction_and_user", unique: true
    t.index ["user_id"], name: "fk_rails_105c1f9428"
  end

  create_table "ai_tutor_interactions", charset: "utf8mb4", collation: "utf8mb4_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "level_id"
    t.integer "script_id"
    t.string "ai_model_version"
    t.string "type"
    t.string "project_id"
    t.string "project_version_id"
    t.text "prompt", size: :medium
    t.string "status"
    t.text "ai_response", size: :medium
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["level_id"], name: "index_ai_tutor_interactions_on_level_id"
    t.index ["script_id"], name: "index_ai_tutor_interactions_on_script_id"
    t.index ["user_id", "level_id", "script_id"], name: "index_ati_user_level_script"
    t.index ["user_id"], name: "index_ai_tutor_interactions_on_user_id"
  end

  create_table "aichat_events", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "user_id"
    t.integer "level_id"
    t.integer "script_id"
    t.integer "project_id"
    t.json "aichat_event"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "level_id", "script_id"], name: "index_ace_user_level_script"
  end

  create_table "aichat_requests", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "level_id"
    t.integer "script_id"
    t.integer "project_id"
    t.json "model_customizations", null: false
    t.json "stored_messages", null: false
    t.json "new_message", null: false
    t.integer "execution_status", null: false
    t.text "response"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "aichat_sessions", charset: "utf8mb4", collation: "utf8mb4_bin", force: :cascade do |t|
    t.integer "user_id"
    t.integer "level_id"
    t.integer "script_id"
    t.integer "project_id"
    t.json "model_customizations"
    t.json "messages"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "level_id", "script_id"], name: "index_acs_user_level_script"
  end

  create_table "assessment_activities", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "level_id", null: false
    t.integer "script_id", null: false
    t.bigint "level_source_id", unsigned: true
    t.integer "attempt"
    t.integer "test_result"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "level_id", "script_id"], name: "index_assessment_activities_on_user_and_level_and_script"
  end

  create_table "authentication_options", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "hashed_email", default: "", null: false
    t.string "credential_type", null: false
    t.string "authentication_id"
    t.text "data"
    t.datetime "deleted_at"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["credential_type", "authentication_id", "deleted_at"], name: "index_auth_on_cred_type_and_auth_id", unique: true
    t.index ["email", "deleted_at"], name: "index_authentication_options_on_email_and_deleted_at"
    t.index ["hashed_email", "deleted_at"], name: "index_authentication_options_on_hashed_email_and_deleted_at"
    t.index ["user_id", "deleted_at"], name: "index_authentication_options_on_user_id_and_deleted_at"
  end

  create_table "authored_hint_view_requests", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "script_id"
    t.integer "level_id"
    t.string "hint_id"
    t.string "hint_class"
    t.string "hint_type"
    t.integer "prev_time"
    t.integer "prev_attempt"
    t.integer "prev_test_result"
    t.bigint "prev_level_source_id", unsigned: true
    t.integer "next_time"
    t.integer "next_attempt"
    t.integer "next_test_result"
    t.bigint "next_level_source_id", unsigned: true
    t.integer "final_time"
    t.integer "final_attempt"
    t.integer "final_test_result"
    t.bigint "final_level_source_id", unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["level_id"], name: "fk_rails_8f51960e09"
    t.index ["script_id", "level_id"], name: "index_authored_hint_view_requests_on_script_id_and_level_id"
    t.index ["user_id", "script_id", "level_id", "hint_id"], name: "index_authored_hint_view_requests_on_all_related_ids"
  end

  create_table "backpacks", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "storage_app_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["storage_app_id"], name: "index_backpacks_on_storage_app_id", unique: true
    t.index ["user_id"], name: "index_backpacks_on_user_id", unique: true
  end

  create_table "blocks", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "pool", default: "", null: false
    t.string "category"
    t.text "config"
    t.text "helper_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_blocks_on_deleted_at"
    t.index ["pool", "name"], name: "index_blocks_on_pool_and_name", unique: true
  end

  create_table "callouts", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "element_id", limit: 1024, null: false
    t.string "localization_key", limit: 1024, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "script_level_id"
    t.text "qtip_config"
    t.string "on"
    t.string "callout_text"
  end

  create_table "cap_user_events", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "name", limit: 64, null: false
    t.integer "user_id", null: false
    t.string "policy", limit: 16, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "state_before", limit: 1
    t.string "state_after", limit: 1
    t.index ["name", "policy"], name: "index_cap_user_events_on_name_and_policy"
    t.index ["policy"], name: "index_cap_user_events_on_policy"
    t.index ["user_id"], name: "index_cap_user_events_on_user_id"
  end

  create_table "census_state_course_codes", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "state"
    t.string "course"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state", "course"], name: "index_census_state_course_codes_on_state_and_course", unique: true
  end

  create_table "census_submission_form_maps", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "census_submission_id", null: false
    t.integer "form_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["census_submission_id"], name: "index_census_submission_form_maps_on_census_submission_id"
    t.index ["form_id"], name: "index_census_submission_form_maps_on_form_id"
  end

  create_table "census_submissions", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "type", null: false
    t.string "submitter_email_address"
    t.string "submitter_name"
    t.string "submitter_role"
    t.integer "school_year", null: false
    t.string "how_many_do_hoc"
    t.string "how_many_after_school"
    t.string "how_many_10_hours"
    t.string "how_many_20_hours"
    t.boolean "other_classes_under_20_hours"
    t.boolean "topic_blocks"
    t.boolean "topic_text"
    t.boolean "topic_robots"
    t.boolean "topic_internet"
    t.boolean "topic_security"
    t.boolean "topic_data"
    t.boolean "topic_web_design"
    t.boolean "topic_game_design"
    t.boolean "topic_other"
    t.string "topic_other_description"
    t.boolean "topic_do_not_know"
    t.string "class_frequency"
    t.text "tell_us_more"
    t.boolean "pledged"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "share_with_regional_partners"
    t.boolean "topic_ethical_social", comment: "Survey option for school courses including ethical and social issues"
    t.boolean "inaccuracy_reported"
    t.text "inaccuracy_comment"
    t.index ["school_year", "id"], name: "index_census_submissions_on_school_year_and_id"
  end

  create_table "census_submissions_school_infos", id: false, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "census_submission_id", null: false
    t.integer "school_info_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["census_submission_id", "school_info_id"], name: "census_submission_school_info_id", unique: true
    t.index ["school_info_id", "census_submission_id"], name: "school_info_id_census_submission", unique: true
  end

  create_table "census_summaries", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "school_id", limit: 12, null: false
    t.integer "school_year", limit: 2, null: false
    t.string "teaches_cs", limit: 2
    t.text "audit_data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id", "school_year"], name: "index_census_summaries_on_school_id_and_school_year", unique: true
  end

  create_table "channel_tokens", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "storage_app_id", null: false
    t.integer "level_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "storage_id", null: false
    t.integer "script_id"
    t.datetime "deleted_at"
    t.index ["storage_app_id"], name: "index_channel_tokens_on_storage_app_id"
    t.index ["storage_id", "level_id", "script_id", "deleted_at"], name: "index_channel_tokens_unique", unique: true
    t.index ["storage_id"], name: "index_channel_tokens_on_storage_id"
  end

  create_table "code_review_comments", charset: "utf8mb4", collation: "utf8mb4_unicode_520_ci", force: :cascade do |t|
    t.integer "code_review_id", null: false
    t.integer "commenter_id"
    t.boolean "is_resolved", null: false
    t.text "comment", size: :medium
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code_review_id"], name: "index_code_review_comments_on_code_review_id"
  end

  create_table "code_review_group_members", id: false, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.bigint "code_review_group_id", null: false
    t.bigint "follower_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code_review_group_id"], name: "index_code_review_group_members_on_code_review_group_id"
    t.index ["follower_id"], name: "index_code_review_group_members_on_follower_id"
  end

  create_table "code_review_groups", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.bigint "section_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["section_id"], name: "index_code_review_groups_on_section_id"
  end

  create_table "code_review_requests", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "script_id", null: false
    t.integer "level_id", null: false
    t.integer "project_id", null: false
    t.string "project_version", null: false
    t.datetime "closed_at"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id", "script_id", "level_id", "closed_at", "deleted_at"], name: "index_code_review_requests_unique", unique: true
  end

  create_table "code_reviews", charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "project_id", null: false
    t.integer "script_id", null: false
    t.integer "level_id", null: false
    t.integer "project_level_id", null: false
    t.string "project_version", null: false
    t.integer "storage_id", null: false
    t.datetime "closed_at"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.virtual "active", type: :boolean, as: "if((`deleted_at` is null),true,NULL)"
    t.virtual "open", type: :boolean, as: "if((`closed_at` is null),true,NULL)"
    t.index ["project_id", "deleted_at"], name: "index_code_reviews_on_project_id_and_deleted_at"
    t.index ["user_id", "project_id", "open", "active"], name: "index_code_reviews_unique", unique: true
    t.index ["user_id", "script_id", "project_level_id", "closed_at", "deleted_at"], name: "index_code_reviews_for_peer_lookup"
  end

  create_table "concepts", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "video_key"
    t.index ["video_key"], name: "index_concepts_on_video_key"
  end

  create_table "concepts_levels", id: :integer, charset: "utf8mb3", collation: "utf8mb3_unicode_ci", force: :cascade do |t|
    t.integer "concept_id"
    t.integer "level_id"
    t.index ["concept_id"], name: "index_concepts_levels_on_concept_id"
    t.index ["level_id"], name: "index_concepts_levels_on_level_id"
  end

