module Versioning
  extend ActiveSupport::Concern
  included do
    has_paper_trail ignore: [:updated_at, :created_at]
  end

  def display_versions
    versions.reverse
  end
end