# typed: true
# frozen_string_literal: true

class AdvisoryMailer < ApplicationMailer
  def new_advisories(advisories_ids, emails)
    return if advisories_ids.blank?

    @advisories = Advisory.where(id: advisories_ids)
    mail(bcc: emails,
         subject: 'Attention! ' \
                  'Found new vulnerabilities in packages you may know!')
  end
end
