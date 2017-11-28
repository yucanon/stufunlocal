class ImageUploader < CarrierWave::Uploader::Base

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(png jpg jpeg gif)
  end

  def filename
    original_filename if original_filename
  end
end
