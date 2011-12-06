module Jekyll
  require 'slim'
  class SlimConverter < Converter
    safe true
    priority :low

    def matches(ext)
      ext =~ /slim/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      engine = Slim::Template.new(pretty: true) { content }
      engine.render
    end
  end
end
