{{
  config({
    "post-hook": [
      "{{create_index(this, 'issue_id')}}",
      "{{create_index(this, 'epic_id')}}",
      "{{create_index(this, 'reporter_id')}}",
      "{{create_index(this, 'assignee_id')}}",
    ]
  })
}}
SELECT
    JIR.id AS issue_id,
    JIR.issue::json->>'key' AS key,
    'parent_id' AS parent_id,
    JIR.issue::json->'fields'->>'statuscategorychangedate' AS status_category_changed_date,
    JIR.issue::json->'fields'->>'timespent' AS time_spent,
    JIR.issue::json->'fields'->'project'->>'id' AS project_id,
    JIR.issue::json->'fields'->'issueType'->>'name' AS issue_type,
    JIR.issue::json->'fields'->'resolution'->>'name' AS resolution,
    JIR.issue::json->'fields'->?'workratio' AS work_ratio,
    TO_TIMESTAMP(JIR.issue::json->'fields'->>'lastViewed', 'YYYY-MM-DD"T"HH24:MI:SS.MSZ') AS last_viewed_date,
    TO_TIMESTAMP(JIR.issue::json->'fields'->>'resolutiondate', 'YYYY-MM-DD"T"HH24:MI:SS.MSZ') AS resolution_date,
    TO_TIMESTAMP(JIR.issue::json->'fields'->>'created', 'YYYY-MM-DD"T"HH24:MI:SS.MSZ') AS created_date,
    TO_TIMESTAMP(JIR.issue::json->'fields'->>'duedate', 'YYYY-MM-DD"T"HH24:MI:SS.MSZ') AS due_date,
    JIR.issue::json->'fields'->'priority'->'priority'->>'name' AS priority,
    JIR.issue::json->'fields'->>'timeoriginalestimate' AS original_estimate,
    TO_TIMESTAMP(JIR.issue::json->'fields'->>'updated', 'YYYY-MM-DD"T"HH24:MI:SS.MSZ') AS last_updated_date,
    JIR.issue::json->'fields'->'status'->>'name' AS status,
    JIR.issue::json->'fields'->?'summary' AS summary,
    JIR.issue::json->'fields'->'description'->>'content' AS description,
    JIR.issue::json->'fields'->'creator'->>'accountId' AS reporter_id,
    JIR.issue::json->'fields'->'assignee'->>'accountId' AS assignee_id,
    JIR.issue::json->'fields'->?'environment' AS environment,
    'remaining_estimate' AS remaining_estimate,
    issue::json
        ->'changelog'
        ->'histories'
        ->(json_array_length(issue::json->'changelog'->'histories')-1)
        ->'author'
        ->?'accountId' AS last_update_by_id,
    'sprint_id' AS sprint_id,
    'epic_id' AS epic_id,
    JIR.issue::json->>'self' AS self_url,
    'JIRA' AS data_source
FROM jira_issue_raw AS JIR
