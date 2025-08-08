class NewslettersController < ApplicationController
  layout "newsletter"
  def show
    issue_number = params[:id].to_i

    content = NewsletterLoader.new(issue_number).load
    @newsletter = Newsletter.new(content)
  end
end
