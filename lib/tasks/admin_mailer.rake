namespace :mailer do
  desc "Sends admin email after event"
  task :admin => :environment do
    if User.where("updated_at >= ?", Time.zone.now.beginning_of_day).count > 0
      Admin.where(email_option: true).each do |admin|
        UserMailer.admin_email(admin).deliver_now
      end
    end
  end
end
