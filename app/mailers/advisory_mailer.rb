# frozen_string_literal: true

class AdvisoryMailer < ApplicationMailer
  def new_advisories(advisories_ids)
    return if advisories_ids.blank?

    @advisories = Advisory.where(id: advisories_ids)
    mail(to: 'serhii.budnik@gmail.com',
         bcc: User.confirmed.pluck(:email),
         subject: 'Attention! ' \
                  'Found new vulnerabilities in packages you may know!')
  end
end
