SELECT
    CONCAT_WS(
        '_',
        item->>'fieldId',
        history->>'created',
        (history->>'author')::json->>'accountId') AS issue_field_history_id,
    item->>'fieldId' AS field_id,
    JIR.issue::json->>'id' AS issue_id,
    history->>'created' AS time_change,
    item->>'toString' AS new_value,
    (history->>'author')::json->>'accountId' AS author_id
FROM jira_issue_raw AS JIR
CROSS JOIN JSON_ARRAY_ELEMENTS(((issue::json->>'changelog')::json->>'histories')::json) AS history
CROSS JOIN JSON_ARRAY_ELEMENTS((history->>'items')::json) AS item
WHERE
    json_array_length(((issue::json->>'changelog')::json->>'histories')::json) > 0;
