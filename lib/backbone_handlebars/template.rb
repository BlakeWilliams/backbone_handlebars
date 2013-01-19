require 'sprockets'
require 'sprockets/engines'
require 'execjs'

module BackboneHandlebars
  class Template < Tilt::Template

    def self.handlebars
      @@handlebars ||= File.new(::Rails.configuration.handlebars.path).read
    end

    def self.default_mime_type
      'application/javascript'
    end

    def prepare; end

    def evaluate(scope, locals, &block)
      path = scope.logical_path.gsub(/^templates\//i, '')

      if ::Rails.configuration.handlebars.precompile == true
        template = precompile_handlebars(path, data)
      else
        template = compile_handlebars(path, data)
      end
    end

    private
    def compile_handlebars(path, string)
      <<-TARGET.gsub /^\s{/, ''\
(function() {
  Handlebars.templates || (Handlebars.templates = {})
  Handlebars.templates['#{path}'] = Handlebars.compile(#{indent(string).inspect});
}).call(this);
      TARGET
    end

    def precompile_handlebars(path, string)
      context = ExecJS.compile(BackboneHandlebars::Template.handlebars)
      template = context.call "Handlebars.precompile", strip(string)
      <<-TARGET.gsub /^\s{/, ''\
(function() {
  Handlebars.templates || (Handlebars.templates = {})
  Handlebars.templates['#{path}'] = Handlebars.template(#{template});
}).call(this);
      TARGET
    end

    def indent(string)
      string.gsub(/$(.)/m, "\\1  ").strip
    end

    def strip(string)
      string.gsub(/\n/, '')
    end

  end
end
