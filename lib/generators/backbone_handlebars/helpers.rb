module BackboneHandlebars
  module Generators
    module Helpers

      def assets_path
        File.join('app', 'assets')
      end

      def javascripts_path
        File.join(assets_path, 'javascripts')
      end

      def models_path
        File.join(javascripts_path, 'models')
      end

      def collections_path
        File.join(javascripts_path, 'collections')
      end

      def helpers_path
        File.join(javascripts_path, 'helpers')
      end

      def routers_path
        File.join(javascripts_path, 'routers')
      end

      def views_path
        File.join(javascripts_path, 'views')
      end

      def templates_path
        File.join(javascripts_path, 'templates')
      end

      def production_config_path
        File.join('config', 'environments', 'production.rb')
      end

      def app_name
        Rails.application.class.name.split('::').first.camelize
      end

    end
  end
end
