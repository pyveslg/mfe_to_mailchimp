class MailchimpCampaignCreator
  def initialize(newsletter, original_issue_number)
    @newsletter = newsletter
    @original_issue_number = original_issue_number
    @html = NewsletterRenderer.new(newsletter).render
  end

  def create_campaign
    gibbon = Gibbon::Request.new

    response = gibbon.campaigns.create(body: {
      type: "regular",
      recipients: {
        list_id: ENV.fetch("MC_AUDIENCE_ID"),
        segment_opts: {
          saved_segment_id: ENV.fetch("MC_MFE_SEGMENT_ID").to_i
        }
      },
      settings: {
        subject_line: "Mon French Expresso: #{@newsletter.title}".strip,
        title: "MFE-#{@original_issue_number}-R",
        from_name: "Fabienne de Novexpat",
        reply_to: "fabienne@novexpat.fr",
        preview_text: @newsletter.preview_text,
        inline_css: true
      }
    })

    campaign_id = response.body[:id]

    gibbon.campaigns(campaign_id).content.upsert(body: {
      html: @html
    })

    campaign_id
  end
end