# Claude code was made a requirement for Summer so this endeavors to keep it as far from my own machines as possible.
{ lib, ... }:
let
  mcps = {
    circleci = {
      url = "https://mcp.circleci.com/v1/mcp";
      replacesConnector = "CircleCI";
      allow = [
        "get_deploy_component"
        "get_deploy_environment"
        "get_job"
        "get_job_logs"
        "get_job_resource_usage"
        "get_me"
        "get_orb"
        "get_orb_source"
        "get_run"
        "get_skill"
        "get_workflow"
        "list_deploy_component_versions"
        "list_deploy_components"
        "list_deploy_environments"
        "list_deployments"
        "list_job_artifacts"
        "list_job_tests"
        "list_run_workflows"
        "list_runs"
        "list_skills"
        "list_workflow_jobs"
        "validate_config"
      ];
    };
    cypress = {
      url = "https://mcp.cypress.io/mcp";
      allow = [
        "cypress_get_projects"
        "cypress_get_runs"
        "cypress_get_specs"
        "cypress_get_tests"
        "cypress_get_failed_tests"
        "cypress_get_flaky_tests"
        "cypress_get_test_screenshots"
        "cypress_get_accessibility_report"
        "cypress_get_accessibility_views"
        "cypress_get_accessibility_rule_failures"
        "cypress_get_ui_coverage_report"
        "cypress_get_ui_coverage_views"
        "cypress_get_ui_coverage_elements"
      ];
    };
    datadog = {
      url = "https://mcp.datadoghq.com/v1/mcp?toolsets=all";
      replacesConnector = "Datadog";
      allow = [
        "aggregate_datadog_ci_pipeline_events"
        "aggregate_datadog_test_events"
        "aggregate_events"
        "aggregate_rum_events"
        "aggregate_spans"
        "analyze_datadog_error_tracking_errors"
        "analyze_datadog_logs"
        "ddsql_create_link"
        "ddsql_get_spec"
        "ddsql_run_query"
        "ddsql_schema_get_table_columns"
        "ddsql_schema_search_tables"
        "ddsql_schema_search_unstructured_fields"
        "find_datadog_database_instances"
        "get_change_stories"
        "get_datadog_dashboard"
        "get_datadog_database_explain_plans"
        "get_datadog_database_query_performance"
        "get_datadog_error_tracking_issue"
        "get_datadog_flaky_tests"
        "get_datadog_incident"
        "get_datadog_metric"
        "get_datadog_metric_context"
        "get_datadog_notebook"
        "get_datadog_trace"
        "get_widget"
        "list_datadog_skills"
        "list_downtimes"
        "load_datadog_skill"
        "monitor_groups_search"
        "read_datadog_documentation"
        "search_datadog_ci_pipeline_events"
        "search_datadog_dashboards"
        "search_datadog_database_samples"
        "search_datadog_documentation"
        "search_datadog_entities"
        "search_datadog_error_tracking_issues"
        "search_datadog_events"
        "search_datadog_hosts"
        "search_datadog_incidents"
        "search_datadog_logs"
        "search_datadog_metrics"
        "search_datadog_monitors"
        "search_datadog_notebooks"
        "search_datadog_rum_events"
        "search_datadog_slos"
        "search_datadog_spans"
        "search_datadog_test_events"
        "visualize_tabular_data"
      ];
    };
    netlify = {
      url = "https://netlify-mcp.netlify.app/mcp";
      allow = [
        "get-netlify-coding-context"
        "netlify-deploy-services-reader"
        "netlify-observability-services-reader"
        "netlify-project-services-reader"
        "netlify-user-services-reader"
      ];
    };
    notion = {
      connector = "Notion";
      ask = [ "notion-move-pages" ];
    };
    posthog = {
      url = "https://mcp.posthog.com/mcp";
      replacesConnector = "PostHog";
    };
    sentry = {
      url = "https://mcp.sentry.dev/mcp";
      allow = [
        "find_dropped_events"
        "find_organizations"
        "find_projects"
        "get_sentry_resource"
        "search_errors"
        "search_issues"
        "search_logs"
        "search_metrics"
        "search_profiles"
        "search_replays"
        "search_sentry_tools"
        "search_traces"
      ];
    };
    shortcut = {
      url = "https://mcp.shortcut.com/mcp";
      replacesConnector = "Shortcut";
      allow = [
        "users-get-current"
        "teams-list"
        "workflows-list"
        "epics-search"
        "epics-get-by-id"
        "stories-search"
        "stories-get-by-id"
      ];
      ask = [
        "stories-create"
        "stories-update"
        "stories-create-subtask"
        "stories-create-comment"
        "epics-create"
        "epics-update"
        "epics-delete"
        "epics-create-comment"
        "iterations-create"
        "iterations-update"
        "iterations-delete"
        "documents-create"
        "documents-update"
      ];
    };
    slack = {
      connector = "Slack";
      allow = [
        "slack_search_public"
        "slack_search_public_and_private"
        "slack_search_channels"
        "slack_search_users"
        "slack_search_emojis"
        "slack_read_channel"
        "slack_read_thread"
        "slack_read_canvas"
        "slack_read_file"
        "slack_read_user_profile"
        "slack_list_channel_members"
        "slack_get_reactions"
      ];
      ask = [
        "slack_send_message"
        "slack_schedule_message"
      ];
    };
  };

  unusedConnectors = [
    "Granola"
    "HubSpot"
    "Intuit QuickBooks"
    "Vanta"
    "ZoomInfo"
  ];

  # the list of MCPs that have URLs.
  servers = lib.filterAttrs (_: mcp: mcp ? url) mcps;

  toolPrefix =
    name: mcp:
    if mcp ? connector then
      "mcp__claude_ai_${lib.replaceStrings [ " " ] [ "_" ] mcp.connector}__"
    else
      "mcp__plugin_hm_${name}__";

  # extracts rules by name from a tool
  toolRules =
    field:
    lib.concatLists (
      lib.mapAttrsToList (name: mcp: map (tool: toolPrefix name mcp + tool) (mcp.${field} or [ ])) mcps
    );

  deniedConnectors = unusedConnectors ++ lib.catAttrs "replacesConnector" (lib.attrValues mcps);
in
{
  # Pulls direnv environments into Claude shells.
  programs.zsh.envExtra = ''
    if [[ -n "$CLAUDECODE" ]]; then
      eval "$(direnv export zsh 2>/dev/null)"
      # 1Password shell plugin CLIs wait on an approval prompt that's easy to miss on multiple monitors.
      op() {
        [[ $1 == plugin ]] && /usr/bin/afplay /System/Library/Sounds/Glass.aiff &!
        command op "$@"
      }
    fi
  '';

  programs.claude-code = {
    enable = true;
    context = ./claude-code.md;
    mutableSettings = true;
    settings = {
      attribution = {
        commit = "";
        pr = "";
      };
      deniedMcpServers = map (connector: { serverName = "claude.ai ${connector}"; }) deniedConnectors;
      # Prevents duplicate tool listings when these also appear in .mcp.json.
      disabledMcpjsonServers = lib.attrNames servers;
      permissions = {
        allow = toolRules "allow";
        ask = toolRules "ask" ++ [ "Bash(gh pr ready *)" ];
        deny = [ "Bash(git * --no-verify*)" ];
      };
    };
    mcpServers = lib.mapAttrs (_: mcp: { inherit (mcp) url; }) servers;
  };
}
