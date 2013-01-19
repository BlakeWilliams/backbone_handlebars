# BackboneHandlebars

A gem that vendors the latest Backbone, Underscore, and Handlebars libraries and compiles/precompiles Handlebars templates.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'backbone_handlebars'
```

## Usage

    rails generate backbone_handlebars:install

This will generate the applications structure in the app/assets/javascripts directory and add the precompile option to your production environment.

## Options

```ruby
config.handlebars.precompile
```

Enables precompilation and will serve only the Handlebars runtime instead of the full library.

```
config.handlebars.path
```

Changes the path of the Handlebars library that precompiles your templates

If you want to use your own Handlebars or Handlebars runtime place them in `vendor/assets/handlebars/development` and `vendor/assets/handlebars/production` respectively.
