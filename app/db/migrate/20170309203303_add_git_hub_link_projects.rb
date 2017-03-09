class AddGitHubLinkProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :git_hub, :string, :default => ""
  end
end
