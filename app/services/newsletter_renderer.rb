class NewsletterRenderer
  def initialize(newsletter)
    @newsletter = newsletter
  end

  def render
    ApplicationController.render(
      template: "newsletters/_insta_template",
      locals: { newsletter: @newsletter },
      layout: "layouts/newsletter"
    )
  end
end
