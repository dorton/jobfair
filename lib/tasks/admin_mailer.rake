namespace :mailer do
  desc "Sends admin email after event"
  task :admin => :environment do
    if User.where("updated_at >= ?", Time.zone.now.beginning_of_day).count > 0
      Admin.find_each do |user|
        UserMailer.admin_email(user).deliver_now
      end
    end
  end
end
