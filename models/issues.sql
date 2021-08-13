SELECT
    JIR.id AS issue_id,
    JIR.issue::json->>'key' AS key,
    'parent_id' AS parent_id,
    (JIR.issue::json->>'fields')::json->>'statuscategorychangedate' AS status_category_changed_date,
    (JIR.issue::json->>'fields')::json->>'timespent' AS time_spent,
    ((JIR.issue::json->>'fields')::json->>'project')::json->>'id' AS project_id,
    ((JIR.issue::json->>'fields')::json->>'issueType')::json->>'name' AS issue_type,
    ((JIR.issue::json->>'fields')::json->>'resolution')::json->>'name' AS resolution,
    (JIR.issue::json->>'fields')::json->>'workratio' AS work_ratio,
    (JIR.issue::json->>'fields')::json->>'lastViewed' AS last_viewed_date,
    (JIR.issue::json->>'fields')::json->>'resolutiondate' AS resolution_date,
    (JIR.issue::json->>'fields')::json->>'created' AS created_date,
    (JIR.issue::json->>'fields')::json->>'duedate' AS due_date,
    (((JIR.issue::json->>'fields')::json->>'priority')::json->>'priority')::json->>'name' AS priority,
    (JIR.issue::json->>'fields')::json->>'timeoriginalestimate' AS original_estimate,
    (JIR.issue::json->>'fields')::json->>'updated' AS last_updated_date,
    ((JIR.issue::json->>'fields')::json->>'status')::json->>'name' AS status,
    (JIR.issue::json->>'fields')::json->>'summary' AS summary,
    ((JIR.issue::json->>'fields')::json->>'description')::json->>'content' AS description,
    ((JIR.issue::json->>'fields')::json->>'creator')::json->>'accountId' AS reporter_id,
    ((JIR.issue::json->>'fields')::json->>'assignee')::json->>'accountId' AS assignee_id,
    (JIR.issue::json->>'fields')::json->>'environment' AS environment,
    'remaining_estimate' AS remaining_estimate,
    'last_update_by_id' AS last_update_by_id,
    'sprint_id' AS sprint_id,
    'epic_id' AS epic_id,
    JIR.issue::json->>'self' AS self_url,
    'JIRA' AS data_source
FROM jira_issue_raw AS JIR
LIMIT 10;

-- issue_id
-- key
-- parent_id
-- status_category_changed_date
-- time_spent
-- project_id
-- issue_type
-- resolution
-- work_ratio
-- last_viewed_date
-- resolved_date
-- created_date
-- due_date
-- priority
-- original_estimate
-- - name: remaining_estimate
-- last_updated_date
-- - name: last_update_by_id
-- status
-- summary
-- description
-- reporter_id
-- assignee_id
-- environment
-- - name: sprint_id
-- - name: epic_id
-- self_url
-- data_source
