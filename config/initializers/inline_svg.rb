# frozen_string_literal: true

InlineSvg.configure do |config|
  config.asset_file = InlineSvg::CachedAssetFile.new(
    paths: [
      "#{Rails.root}/public/icons",
      "#{Rails.root}/public/svgs"
    ],
    filters: /\.svg/
  )
end
