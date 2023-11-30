require "administrate/field/base"

class ActiveStorageField < Administrate::Field::Base
  def to_s
    data
  end

  def url
    Rails.application.routes.url_helpers.rails_blob_path(data, only_path: true) if data.attached?
  end
end