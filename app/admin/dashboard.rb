# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  page_action :generate_weekplan, method: :post do
    CleaningPlan.generate_weekplan
    CleaningPlan.notify_telegram
    redirect_to admin_dashboard_path, notice: "neuer plan erstellt"
  end

  action_item :generate_weekplan do
    link_to "Neuer Putzplan", admin_dashboard_generate_weekplan_path, method: :post
  end

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "putzhistorie" do
      columns do
        column do
          panel "this week of putz" do
            pie_chart CleaningTask.current_week.group(:done).count, ytitle: 'done'
          end
        end

        column do
          panel "roomhistory" do
            column_chart CleaningTask.all.group_by { |o| [o.room.name, o.done ? 'Done' : 'Not Done'] }.transform_values(&:count)
          end
        end
      end
    end

    div class: "blank_slate_container", id: "essenskassenhistorie" do
      columns do
        column do
          panel "food account history" do
            line_chart HistoricalSum.all.group_by_day(:created_at).sum(:food)
          end
        end
      end
    end
  end

  # Here is an example of a simple dashboard with columns and panels.
  #
  # columns do
  #   column do
  #     panel "Recent Posts" do
  #       ul do
  #         Post.recent(5).map do |post|
  #           li link_to(post.title, admin_post_path(post))
  #         end
  #       end
  #     end
  #   end

  #   column do
  #     panel "Info" do
  #       para "Welcome to ActiveAdmin."
  #     end
  #   end
  # end
  # content
end
