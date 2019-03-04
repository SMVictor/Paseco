CarrierWave.configure do |config|
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
      provider:              'AWS',
      aws_access_key_id:     Rails.application.credentials.aws[:S3_KEY],
      aws_secret_access_key: Rails.application.credentials.aws[:S3_SECRET],
      region:                Rails.application.credentials.aws[:S3_REGION],
  }
  config.cache_dir = "#{Rails.root}/tmp/uploads" 
  config.fog_directory  = Rails.application.credentials.aws[:S3_BUCKET]
end