# frozen_string_literal: true

# See the Ruby OEmbed GitHub for more details
# https://github.com/ruby-oembed/ruby-oembed

# Facebook/Instagram requires an `OEMBED_FACEBOOK_TOKEN` env var.
# This token is either a Facebook App Access Token (recommended) or Client Access Token.

OEmbed::Providers.register_all
OEmbed::Providers.register_fallback(
  OEmbed::ProviderDiscovery,
  OEmbed::Providers::Noembed
)

# Allow injecting OEmbed HTML into ActionText, but only allow script tags from trusted sources
# Soundcloud, Spotify, Vimeo, and YouTube use iframe embeds instead of script tags
Rails.application.config.to_prepare do
  ActionText::ContentHelper.allowed_tags += %w[iframe script blockquote time]
  ActionText::ContentHelper.allowed_attributes += %w[data-id data-flickr-embed target]
  ActionText::ContentHelper.scrubber = Loofah::Scrubber.new do |node|
    if node.name == "script" && !ActionText::Embed.allowed_script?(node)
      node.remove
      Loofah::Scrubber::STOP # don't bother with the rest of the subtree
    end
  end
end
