class Newsletter
  attr_reader :data

  def initialize(data)
    @data = data.deep_symbolize_keys
  end

  def title
    data[:title]
  end

  def preview_text
    data[:preview_text]
  end

  def color
    generate_pastel_color
  end

  def goal
    data[:goal]
  end
  
  def challenge_statement
    data.dig(:challenge, :state)
  end

  def challenge_options
    data.dig(:challenge, :options) || []
  end

  OPTION_LABELS = ('a'..'z').to_a.map { |l| "#{l})" }

  def shuffled_challenge_options
    options = challenge_options.shuffle
    options.each_with_index.map do |opt, idx|
      opt.merge(label: OPTION_LABELS[idx])
    end
  end

  def correct_option_label(options)
    correct = options.find { |opt| opt[:correct] }
    correct ? correct[:label] : nil
  end

  def correct_option
    challenge_options.find { |opt| opt[:correct] == true }
  end

  def explanation_fr
    data.dig(:explanation, :fr)
  end

  def explanation_en
    data.dig(:explanation, :en)
  end

  def words
    data[:words] || []
  end

  def end_question
    data[:end_question]
  end

  private

  def generate_pastel_color
    hue = rand(0..360)
    saturation = rand(40..60) # mild saturation
    lightness = rand(80..90)  # bright pastel
  
    hsl_to_hex(hue, saturation, lightness)
  end
  
  # Convert HSL to RGB, then to HEX
  def hsl_to_hex(h, s, l)
    s /= 100.0
    l /= 100.0
  
    c = (1 - (2 * l - 1).abs) * s
    x = c * (1 - ((h / 60.0) % 2 - 1).abs)
    m = l - c / 2
  
    r, g, b = case h
    when 0...60
      [c, x, 0]
    when 60...120
      [x, c, 0]
    when 120...180
      [0, c, x]
    when 180...240
      [0, x, c]
    when 240...300
      [x, 0, c]
    else
      [c, 0, x]
    end
  
    r = ((r + m) * 255).round
    g = ((g + m) * 255).round
    b = ((b + m) * 255).round
  
    format("#%02x%02x%02x", r, g, b)
  end


end
