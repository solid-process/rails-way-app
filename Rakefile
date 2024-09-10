# frozen_string_literal: true

# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require "rubycritic/rake_task"

require_relative "config/application"

RubyCritic::RakeTask.new do |task|
  task.paths = FileList["app/**/*.rb"]

  task.options = "--no-browser"
end

Rails.application.load_tasks
