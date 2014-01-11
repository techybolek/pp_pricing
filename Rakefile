#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'warbler'
require 'jshintrb/jshinttask'

PpPricing::Application.load_tasks

Warbler::Task.new
task :war => "assets:clean"
task :war => "assets:precompile"

Jshintrb::JshintTask.new :jshint do |t|
  t.pattern = "app/assets/javascripts/*.js"
  t.exclude_js_files = ["app/assets/javascripts/jquery-ui-1.10.1.custom.js",
                        "app/assets/javascripts/bootstrap.js",
                        "app/assets/javascripts/bootstrap-editable.js",
                        "app/assets/javascripts/analytics.js",
                        "app/assets/javascripts/select2.js",
                        "app/assets/javascripts/modernizr.js",
                        "app/assets/javascripts/jquery.filterable.min.js",
                        "app/assets/javascripts/alertify.js",
                        "app/assets/javascripts/bootstrap-hover-dropdown.js",
                        "app/assets/javascripts/jstree.js"]
  t.globals = ["Modernizr", "unsavedChanges", "showSuccess", "showNotice", "showAlert", "showError", "alertify"]
  t.options = {
                :bitwise => true,
                :curly => true,
                :eqeqeq => true,
                :forin => true,
                :immed => true,
                :latedef => true,
                :newcap => true,
                :noarg => true,
                :noempty => true,
                :nonew => true,
                :plusplus => false,
                :regexp => true,
                :undef => true,
                :trailing => true,
                :browser => true,
                :sub => true,
                :eqnull => true,
                :jquery => true,
                :unused => false,
                :camelcase => true,
                :quotmark => true,
                :devel => true,
                :unused => true
              }
end
