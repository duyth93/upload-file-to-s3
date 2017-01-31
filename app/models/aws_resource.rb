module AwsResource
  class << self
    def for(aws_service, options = {})
      aws_service::Resource.new(
        options.merge(
          access_key_id: Rails.application.secrets.aws_access_key_id,
          secret_access_key: Rails.application.secrets.aws_secret_access_key
      ))
    end
  end
end
