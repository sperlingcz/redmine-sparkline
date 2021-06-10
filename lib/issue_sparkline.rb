require 'action_view/helpers/tag_helper'

class IssueSparkline
  include ActionView::Helpers::TagHelper

  def initialize(issue, options={})
    @issue = issue
    @min_x = issue.created_on.to_date
    @values = Hash.new
    issue.journals.each do |journal|
      details = journal.visible_details.select { |det| det.prop_key == 'done_ratio' }
      details.each do |detail|
        if @values.blank?
          @values[@min_x] = detail.old_value
        else
          @values[journal.created_on.to_date] = detail.value
        end
      end
    end
    @max_x = Time.now.to_date
    @values[@max_x] = issue.done_ratio.to_s

    case SparklineSetting[:x_min, issue.project.id]
    when "offset"
       @min_x = (Time.now - SparklineSetting[:time_offset, issue.project.id].to_i * 60 * 60 * 24).to_date
       last = nil
       @values.each do |key,value|
         if key < @min_x
           last = [key, value]
           @values.delete(key)
         end
       end

       unless last.nil? || @values[@min_x]
         first = @values.first
         vali = last[1].to_i + (last[1].to_i - first[1].to_i)/(last[0] - first[0])*(@min_x - last[0])
         @values[@min_x] = vali.to_i.to_s
       end
    when "issue_created"
    else
    end

    case SparklineSetting[:x_max, issue.project.id]
    when "today"
    when "issue_due"
      unless issue.due_date.blank?
        @max_x = issue.due_date.to_date
      end
    else
    end
  end


  def  to_tag(tag=:div)
    string_values = []
    @values.sort.to_h.each {|key, value| string_values.append "#{key.to_time.to_i}:#{value}" }
    content_tag(tag,
                "",
                values:  @issue.project.enabled_module(:sparkline) ? string_values.join(",") : "",
                class: 'done_ratio_sparkline',
                issueId: @issue.id,
                sparkType: 'line',
                sparkWidth: '150',
                sparkHeight: '25',
                sparkChartRangeMin: '0',
                sparkChartRangeMax: '100',
                sparkChartRangeMinX: @min_x.to_time.to_i.to_s,
                sparkChartRangeMaxX: @max_x.to_time.to_i.to_s
                )
  end
end
