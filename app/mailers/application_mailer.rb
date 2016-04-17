class ApplicationMailer < ActionMailer::Base
  default from: "Event Mailer <noreply@theironyard.com>",
          reply_to: "noreply@theironyard.com"
  layout 'mailer'
end
