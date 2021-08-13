{{
  config({
    "post-hook": 'create index if not exists {{ this.name }}__index_on_FIELD on {{ this }} ("epic_id")'
    })
}}
SELECT
    JIR.id AS epic_id,
    JIR.issue::json->'key' AS key,
    JIR.issue::json->'fields'->>'summary' AS epic_name,
    JIR.issue::json->'fields'->>'timespent' AS time_spent,
    JIR.issue::json->'fields'->'project'->>'id' AS project_id,
    JIR.issue::json->'fields'->'issueType'->>'name' AS issue_type,
    JIR.issue::json->'fields'->'resolution'->>'name' AS resolution,
    JIR.issue::json->'fields'->>'workratio' AS work_ratio,
    TO_TIMESTAMP(JIR.issue::json->'fields'->>'lastViewed', 'YYYY-MM-DD"T"HH24:MI:SS.MSZ') AS last_viewed_date,
    TO_TIMESTAMP(JIR.issue::json->'fields'->>'resolutiondate', 'YYYY-MM-DD"T"HH24:MI:SS.MSZ') AS resolution_date,
    TO_TIMESTAMP(JIR.issue::json->'fields'->>'created', 'YYYY-MM-DD"T"HH24:MI:SS.MSZ') AS created_date,
    TO_TIMESTAMP(JIR.issue::json->'fields'->>'duedate', 'YYYY-MM-DD"T"HH24:MI:SS.MSZ') AS due_date,
    JIR.issue::json->'fields'->>'updated' AS last_updated_date,
    JIR.issue::json->'fields'->'status'->>'name' AS status,
    JIR.issue::json->'fields'->'description'->>'content' AS description,
    JIR.issue::json->'fields'->'creator'->>'accountId' AS reporter_id,
    JIR.issue::json->'fields'->'assignee'->>'accountId' AS assignee_id,
    JIR.issue::json->'fields'->'priority'->>'name' AS priority,
    JIR.issue::json->'fields'->>'environment' AS environment,
    'feature_id' AS feature_id,
    issue::json
        ->'changelog'
        ->'histories'
        ->(json_array_length(issue::json->'changelog'->'histories')-1)
        ->'author'
        ->'accountId' AS last_update_by_id,
    JIR.issue::json->'self' AS self_url,
    'JIRA' AS data_source
FROM jira_issue_raw AS JIR
WHERE issue::json->'fields'->'issuetype'->>'name' = 'Epic'
