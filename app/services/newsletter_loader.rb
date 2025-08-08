require "yaml"

class NewsletterLoader
  def initialize(number)
    @file_path = Rails.root.join("data/MFE##{number}.yml")
  end

  def load
    YAML.load_file(@file_path).deep_symbolize_keys
  end
end