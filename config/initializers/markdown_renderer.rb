class MarkdownRenderer < Redcarpet::Render::HTML
  def preprocess(full_document)
    # Replace ~text~ with <u>text</u>
    full_document.gsub(/~(.*?)~/, '<u>\1</u>')
  end

  def paragraph(text)
    text # Don't wrap in <p>
  end
end

module MarkdownHelper
  def markdown(text)
    renderer = MarkdownRenderer.new(
      filter_html: false,
      hard_wrap: true
    )
    markdown = Redcarpet::Markdown.new(renderer, {
      autolink: true,
      tables: true,
      fenced_code_blocks: true,
      strikethrough: true
    })
    html = markdown.render(text)
    html.gsub!("\n", "<br>")
    html.html_safe
  end
end