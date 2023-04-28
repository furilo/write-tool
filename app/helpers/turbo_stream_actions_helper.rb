# frozen_string_literal: true

module TurboStreamActionsHelper
  module CustomTurboStreamActions
    # Add your own custom Turbo StreamAction helpers
    # These will automatically be made available on the `turbo_stream` helper
    # Add the matching StreamAction in `app/javascripts/src/turbo_streams.js`

    # turbo_stream.remove_later("my-id", after: "2000")
    def remove_later(target, after: "2000")
      turbo_stream_action_tag :remove_later, target:, after:
    end

    def reset_form(target)
      turbo_stream_action_tag :reset_form, target:
    end

    def scroll_to(target)
      turbo_stream_action_tag :scroll_to, target:
    end
  end

  Turbo::Streams::TagBuilder.prepend(CustomTurboStreamActions)
end
