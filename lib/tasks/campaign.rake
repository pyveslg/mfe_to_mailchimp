namespace :campaign do
  desc "Create a campaign"
  task :create => :environment do |t, args|
    initial_newsletter_issue_number = ENV['id']&.to_i

    if initial_newsletter_issue_number <= 0
      puts "❌ Please provide a valid integer"
      exit 1
    end

    puts "📦 Loading newsletter #{initial_newsletter_issue_number}..."

    content = NewsletterLoader.new(initial_newsletter_issue_number).load
    newsletter = Newsletter.new(content)

    puts "📤 Creating Mailchimp campaign draft..."
    campaign_id = MailchimpCampaignCreator.new(newsletter, initial_newsletter_issue_number).create_campaign
    puts "✅ Campaign draft created: #{campaign_id}"
  end
end
