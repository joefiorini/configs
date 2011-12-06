module AudioFilter

  def audio sources
    site = @context.registers[:site]
    tag = [%{<audio controls="" height="20" width="320">}]
    sources.inject tag do |t,source|
      t << %{  <source src="#{site.config["episode_bucket"]}#{source.first}" type="#{source.last}">}
    end
    tag << "</audio>"
    tag.join "\n"
  end

  def download_path source
    site = @context.registers[:site]
    "#{site.config["episode_bucket"]}#{source.first}"
  end

end
Liquid::Template.register_filter(AudioFilter)
