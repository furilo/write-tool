# frozen_string_literal: true

class SandboxController < ApplicationController
  layout :resolve_layout

  def index
    @templates = Dir.glob(Rails.root.join("app/views/sandbox/*.html.erb").to_s).sort.map do |filename|
      filename = File.basename(filename, File.extname(filename))
      filename unless filename.starts_with?("_") || filename == "index.html"
    end.compact
  end

  def show
    if params[:template].index(".") # CVE-2014-0130
      render action: "index"
    elsif lookup_context.exists?("sandbox/#{params[:template]}")
      if params[:template] == "index"
        render action: "index"
      else
        render "sandbox/#{params[:template]}"
      end
    end
  end

  private

  def resolve_layout
    params.fetch(:template, "").start_with?("mail") ? "email" : "sandbox"
  end
end
