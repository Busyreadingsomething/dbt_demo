SELECT
    CONCAT_WS(
        '_',
        item->>'fieldId',
        history->>'created',
        history->'author'->>'accountId') AS issue_field_history_id,
    item->'fieldId' AS field_id,
    JIR.id AS issue_id,
    -- history->'created' AS time_change,
    TO_TIMESTAMP(history->>'created', 'YYYY-MM-DD"T"HH24:MI:SS.MSZ') AS time_change,
    item->>'toString' AS new_value,
    history->'author'->>'accountId' AS author_id
FROM jira_issue_raw AS JIR
CROSS JOIN JSON_ARRAY_ELEMENTS(issue::json->'changelog'->'histories') AS history
CROSS JOIN JSON_ARRAY_ELEMENTS(history->'items') AS item
WHERE json_array_length(issue::json->'changelog'->'histories') > 0
