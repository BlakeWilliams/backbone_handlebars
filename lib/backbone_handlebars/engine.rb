require 'backbone_handlebars/template'

module BackboneHandlebars
  class Engine < Rails::Engine
    config.handlebars = ActiveSupport::OrderedOptions.new

    config.handlebars.path = File.expand_path("../../../vendor/assets/handlebars/development/handlebars.js", __FILE__)
    config.handlebars.templates_root "templates"

    initializer "backbone_handlebars.setup", after: 'sprockets.environment', group: :all do |app|
      version = "production" if app.config.handlebars.precompile == true
      version ||= "development"

      path = File.expand_path("../../../vendor/assets/handlebars/#{version}", __FILE__)
      app.config.assets.paths.push(path.to_s)

      path = app.root.join("vendor/assets/handlebars/#{version}")
      app.config.assets.paths.unshift(path.to_s) if path.exist?

      next unless app.assets
      app.assets.register_engine '.handlebars', BackboneHandlebars::Template
      app.assets.register_engine '.hbs', BackboneHandlebars::Template
      app.assets.register_engine '.hjs', BackboneHandlebars::Template
    end
  end
end
