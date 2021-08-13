SELECT
    id,
    -- updated,
    -- issue,
    cast(issue AS json) AS json_data,
    issue::json->> 'id' as issue_id,
    ((issue::json->> 'fields')::json->>'issuetype')::json->>'name' AS task,
    issue::json->> 'key' as key
FROM jira_issue_raw
LIMIT 10;