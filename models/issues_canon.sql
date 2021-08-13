{##}
SELECT
    JIR.id AS issue_id,
    JIR.issue::json->'key' AS key,
    'parent_id' AS parent_id,
    JIR.issue::json->'fields'->'statuscategorychangedate' AS status_category_changed_date,
    JIR.issue::json->'fields'->'timespent' AS time_spent,
    JIR.issue::json->'fields'->'project'->'id' AS project_id,
    JIR.issue::json->'fields'->'issueType'->'name' AS issue_type,
    JIR.issue::json->'fields'->'resolution'->'name' AS resolution,
    JIR.issue::json->'fields'->'workratio' AS work_ratio,
    JIR.issue::json->'fields'->'lastViewed' AS last_viewed_date,
    JIR.issue::json->'fields'->'resolutiondate' AS resolution_date,
    JIR.issue::json->'fields'->'created' AS created_date,
    JIR.issue::json->'fields'->'duedate' AS due_date,
    JIR.issue::json->'fields'->'priority'->'priority'->'name' AS priority,
    JIR.issue::json->'fields'->'timeoriginalestimate' AS original_estimate,
    JIR.issue::json->'fields'->'updated' AS last_updated_date,
    JIR.issue::json->'fields'->'status'->'name' AS status,
    JIR.issue::json->'fields'->'summary' AS summary,
    JIR.issue::json->'fields'->'description'->'content' AS description,
    JIR.issue::json->'fields'->'creator'->'accountId' AS reporter_id,
    JIR.issue::json->'fields'->'assignee'->'accountId' AS assignee_id,
    JIR.issue::json->'fields'->'environment' AS environment,
    'remaining_estimate' AS remaining_estimate,
    issue::json
        ->'changelog'
        ->'histories'
        ->(json_array_length(issue::json->'changelog'->'histories')-1)
        ->'author'
        ->'accountId' AS last_update_by_id,
    'sprint_id' AS sprint_id,
    'epic_id' AS epic_id,
    JIR.issue::json->>'self' AS self_url,
    'JIRA' AS data_source
FROM jira_issue_raw AS JIR;
