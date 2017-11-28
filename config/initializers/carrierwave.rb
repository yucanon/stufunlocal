CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: 'AWS',
    aws_access_key_id: 'AKIAJC2UGXLSPZCEBHNA',
    aws_secret_access_key: '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',
    region: 'ap-northeast-1'
  }
  config.fog_directory = 'stufun'
end