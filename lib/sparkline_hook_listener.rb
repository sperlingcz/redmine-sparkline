class SparklineHookListener < Redmine::Hook::ViewListener
  render_on :view_issues_index_bottom, partial: "hooks/sparkline_issues_list"

   render_on :view_issues_show_details_bottom, partial: "hooks/sparkline_issues_show"
end