require 'generators/backbone_handlebars/helpers'

module BackboneHandlebars
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include BackboneHandlebars::Generators::Helpers

      source_root File.expand_path('../templates', __FILE__)
      
      desc "Generates Backbone skeleton directory structure"

      class_option :manifest,
                    type: :string,
                    aliases: "-m",
                    default: "application.js",
                    desc: "Javascript manifest file to modify"

      def create_dir_layout
        empty_directory collections_path
        empty_directory helpers_path
        empty_directory models_path
        empty_directory routers_path
        empty_directory templates_path 
        empty_directory views_path
      end

      def create_app_file
        template "app.coffee", "#{javascripts_path}/#{app_name.downcase}.coffee"
      end

      def inject_files
        manifest = File.join(javascripts_path, options.manifest)

        libs = %w[underscore backbone handlebars]
        paths = %w(./helpers ./templates ./models ./collections ./views ./routers)

        out = []
        out << libs.map { |lib| "//= require #{lib}" }
        out << "//= require #{app_name.downcase}"
        out << paths.map { |path| "//= require_tree #{path}" }
        out = out.join("\n") + "\n"

        in_root do
          return unless File.exists?(manifest)
          if File.open(manifest).read().include?('//= require_tree .')
            inject_into_file(manifest, out, before: '//= require_tree .')
          else
            append_file(manifest, out)
          end
        end
      end

      def inject_production_config
        in_root do
          return unless File.exists?(production_config_path)

          out = []
          out << ["  # Specify if you want Handlebars precompiled in this environment"]
          out << ["  config.handlebars.precompile = true"]
          out = "\n#{out.join("\n")}\n"

          inject_into_file(production_config_path, out, before: "\nend")
        end
      end
      
    end
  end
end
